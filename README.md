Base project for Ocaml project on Ford-Fulkerson. 

Compiler : make

Pour lancer il faut choisir un graphe sur lequel on applique l'algorithme de Ford Fulkerson
Le programme va alors retourner un graph correspondant à la solution au problème de flot sur ce graphe

Test : ./ftest.native <chemin du graphe à tester> source puits <chemin pour la solution> 

Affichage terminal : 
    -Les différents chemins (sans la source) affichés avec la valeur maximale de laquelle on incrémente ce chemin
    -La solution finale en indiquant le flot maximal du graphe.

Fichier de retour : Le graphe de solution au format de base et le graphe au format.dot

Transformer le .dot en .svg : "dot -Tsvg your-dot-file > some-output-file.svg"


L'algorithme de Ford_Fulkerson fonctionne correctement. 

