-- ============================================
-- EJERCICIOS SQL EN CONTEXTO ACTUARIAL
-- Tablas: asegurados, polizas, siniestros
-- ============================================

-- 1. FILTRO BÁSICO
-- Obtener todas las pólizas activas
-- (English note: "active policies" — useful term in any insurance dataset)
SELECT id_poliza, asegurado_id, tipo_seguro, prima_anual, estatus
FROM polizas
WHERE estatus = 'activa';

-- 2. FILTRO CON COMPARACIÓN NUMÉRICA
-- Pólizas cuya prima anual supera los $10,000
SELECT id_poliza, tipo_seguro, prima_anual
FROM polizas
WHERE prima_anual > 10000;

-- 3. FILTRO CON MÚLTIPLES CONDICIONES (AND)
-- Pólizas de tipo "vida" que estén activas
SELECT id_poliza, asegurado_id, prima_anual
FROM polizas
WHERE tipo_seguro = 'vida' AND estatus = 'activa';

-- 4. FILTRO CON OR
-- Pólizas de tipo "auto" o "vida"
SELECT id_poliza, tipo_seguro
FROM polizas
WHERE tipo_seguro = 'auto' OR tipo_seguro = 'vida';

-- 5. BETWEEN
-- Pólizas con prima anual entre $5,000 y $15,000
SELECT id_poliza, prima_anual
FROM polizas
WHERE prima_anual BETWEEN 5000 AND 15000;

-- 6. LIKE (búsqueda de patrones)
-- Asegurados cuyo nombre empieza con "Mar"
SELECT id_asegurado, nombre
FROM asegurados
WHERE nombre LIKE 'Mar%';

-- 7. ORDER BY
-- Pólizas ordenadas de mayor a menor prima
SELECT id_poliza, tipo_seguro, prima_anual
FROM polizas
ORDER BY prima_anual DESC;

-- 8. COUNT + GROUP BY
-- Número de siniestros por tipo
SELECT tipo_siniestro, COUNT(*) AS total_siniestros
FROM siniestros
GROUP BY tipo_siniestro;

-- 9. SUM + GROUP BY
-- Monto total pagado en siniestros, por tipo de seguro
SELECT p.tipo_seguro, SUM(s.monto_pagado) AS total_pagado
FROM siniestros s
JOIN polizas p ON s.poliza_id = p.id_poliza
GROUP BY p.tipo_seguro;

-- 10. HAVING (filtrar después de agrupar)
-- Tipos de seguro con más de 5 siniestros registrados
SELECT p.tipo_seguro, COUNT(*) AS total_siniestros
FROM siniestros s
JOIN polizas p ON s.poliza_id = p.id_poliza
GROUP BY p.tipo_seguro
HAVING COUNT(*) > 5;
