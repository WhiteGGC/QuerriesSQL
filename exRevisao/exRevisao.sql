/*1*/
SELECT e.nome, e.valor, ed.nome, a.nome
FROM estoque e, autor a, editora ed
WHERE e.codAutor = a.codigo
	AND e.codEditora = ed.codigo
GROUP BY e.nome, e.valor, ed.nome, a.nome
ORDER BY e.nome, e.valor, ed.nome, a.nome

/*2*/
SELECT e.nome, e.quantidade, c.valor 
FROM estoque e, compra c
WHERE e.codigo = c.codEstoque
	AND c.codigo = 15051

/*3*/
SELECT e.nome, 
CASE WHEN LEN(d.site) > 10 THEN 
SUBSTRING(d.site, 5, 10) ELSE
d.site
END AS site
FROM estoque e, editora d
WHERE e.codEditora = d.codigo
	AND d.nome LIKE 'Makron Books'

/*4*/
SELECT e.nome, a.biografia
FROM estoque e, autor a
WHERE e.codAutor = a.codigo
	AND a.nome LIKE 'David Halliday'

/*5*/
SELECT c.codigo, e.quantidade
FROM estoque e, compra c
WHERE e.codigo = c.codEstoque
	AND e.nome LIKE 'Sistemas Operacionais Modernos'

/*6*/
SELECT e.nome
FROM estoque e LEFT OUTER JOIN compra c
ON e.codigo = c.codEstoque
WHERE c.codigo IS NULL

/*7*/
SELECT e.nome
FROM estoque e RIGHT OUTER JOIN compra c
ON e.codigo = c.codEstoque
WHERE e.codigo IS NULL

/*8*/
SELECT d.nome,
CASE WHEN LEN(d.site) > 10 THEN 
SUBSTRING(d.site, 5, 10) ELSE
d.site
END AS site
FROM estoque e RIGHT OUTER JOIN editora d
ON e.codEditora = d.codigo
WHERE e.codigo IS NULL

/*9*/
SELECT a.nome,
CASE WHEN a.biografia LIKE 'Doutorado' THEN 
'Ph.D. ' + SUBSTRING(a.biografia, 10, 100) ELSE
a.biografia
END AS biografia
FROM estoque e RIGHT OUTER JOIN autor a
ON e.codAutor = a.codigo
WHERE e.codigo IS NULL

/*10*/
SELECT a.nome, e.valor
FROM estoque e, autor a 
WHERE e.codAutor = a.codigo
AND e.valor in(
	SELECT MAX(VALOR)
	FROM estoque
)
ORDER BY e.valor DESC

/*11*/
SELECT c.codigo, c.qtdComprada, SUM(c.valor) AS soma_valores
FROM compra c
GROUP BY c.codigo, c.qtdComprada
ORDER BY c.codigo ASC

/*12*/
SELECT d.nome, AVG(e.valor) AS media
FROM editora d, estoque e
WHERE d.codigo = e.codEditora
GROUP BY d.nome
ORDER BY media ASC

/*13*/
SELECT e.nome, e.quantidade, d.nome,
CASE WHEN LEN(d.site) > 10 THEN 
SUBSTRING(d.site, 5, 10) ELSE
d.site
END AS site,
status = CASE
		WHEN e.quantidade < 5 THEN
			'Produto em Ponto de Pedido'
		WHEN e.quantidade > 5 AND e.quantidade < 10 THEN
			'Produto Acabando'
		ELSE
			'Estoque Suficiente'
		END
FROM estoque e, editora d
WHERE e.codEditora = d.codigo

/*14*/
SELECT e.codigo AS 'Codigo do Livro',
e.nome AS 'Nome do Livro',
a.nome AS 'Nome do Autor',
CASE WHEN d.site IS NULL THEN
	d.nome
	ELSE
	d.nome + ' ' + d.site
END AS 'Info Editora'
FROM editora d, autor a, estoque e
WHERE e.codAutor = a.codigo
AND e.codEditora = d.codigo

/*15*/
SELECT codigo, 
DATEDIFF(DAY, dataCompra, GETDATE()) AS dias, 
DATEDIFF(MONTH, dataCompra, GETDATE()) AS meses
FROM compra

/*16*/
SELECT codigo, SUM(valor)
FROM compra
GROUP BY codigo
HAVING SUM(valor) > 200