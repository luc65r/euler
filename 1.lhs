# Multiples de 3 et de 5

Si on liste tous les nombres naturels inférieurs à 10 qui sont multiples de 3 ou 5, on obtient 3, 5, 6 et 9.
La somme de ces multiples est 23.

Trouver la somme de tous les multiples de 3 ou 5 inférieurs à 1000.

## Filtrage de liste

Pour avoir le résultat, on peut filtrer la liste des nombres naturels de 1 à 999 pour n'avoir que les multiples de 3 ou 5, et faire la somme de tous les éléments de cette liste.

```haskell
m1 = sum . filter (\x -> x `mod` 3 == 0 || x `mod` 5 == 0) $ [1 .. 999]
```

`[1 .. 999]` génère la liste des nombres naturels de 1 à 999, comme ceci : `[1, 2, 3, ..., 997, 998, 999]`.
On filtre cette liste avec la fonction anonyme ``\x -> x `mod` 3 == 0 || x `mod` 5 == 0``.
[//]: # (TODO: expliquer celle lambda expression)
Et on fait la somme de tous les éléments de la liste.

## Compréhension de liste

On peut aussi utiliser les compréhensions de liste pour faire exactement la même chose que précédemment.

```haskell
m2 = sum [x | x <- [1 .. 999], x `mod` 3 == 0 || x `mod` 5 == 0]
```

## Méthode efficace

Le problème des méthodes précédentes, c'est qu'elles ne sont pas tellement efficaces ; on appelle `mod` beaucoup de fois, donc le programme risque d'être lent si on lui demande de faire la somme de tous les multiples inférieurs à 1 000 000 000.

La solution, c'est de réfléchir avant de faire le programme !
Pour avoir tous les multiples de 3, il suffit de mutiplier tous les entiers naturels par 3, de même pour 5.
Le problème c'est que les multiples de 3 et de 5 vont être comptés deux fois, donc il faut enlever les multiples de 15.

```haskell
m3 = (sum . takeWhile (< 1000) . map (*3) $ [1 ..])
    + (sum . takeWhile (< 1000) . map (*5) $ [1 ..])
    - (sum . takeWhile (< 1000) . map (*15) $ [1 ..])
```

Ici, `map (*3)` applique `*3` à tous les éléments de la liste infinie `[1 ..]`, et on fait la somme de tous les éléments de la liste tant qu'ils sont inférieurs à 1000.


Mais il y a plus simple !
On peut déterminer là ou on doit s'arrêter dans la liste des entiers : il faut s'arrêter à 999 / 3 pour les multiples de 3, 999 / 5 pour les multiples de 5 et 999 / 15 pour les multiples de 15.
Notons que 999 / 5 et 999 / 15 doivent être arrondis à l'entier inférieur.
Et puis n'oublions pas que 1 + 2 + 3 + ... + n = n (n + 1) / 2

On peut donc définir la fonction `divisiblePar`

```haskell
divisiblePar n = n * p * (p + 1) `div` 2
    where p = 999 `div` n
```

Et maintenant on peut faire

```haskell
m4 = divisiblePar 3 + divisiblePar 5 - divisiblePar 15
```

---

```haskell
main = putStrLn $ show m4
```
