# Тестовое задание на должность "Младший продуктовый аналитик в SuperAppKit"

## Часть 1 (SQL)

<div style="text-align: justify">

### Задание 1

Имеется таблица с начислениями за каждый год (Таблица 1). Необходимо посчитать величину начисления нарастающим итогом в порядке увеличения года (Таблица 2). При этом если начисление текущего года меньше нарастающего итога предыдущих лет, то этот год не вносит свой вклад в нарастающий итог.

<table align="center">
<tr>
    <th>Таблица 1. Исходная таблица</th>
    <th>Таблица 2. Результирующая таблица</th>
</tr>
<tr>
    <td align="center">

| year  | accrual |
|:-----:|:-------:|
| 2015  | 5       |
| 2016  | 5       |
| 2017  | 10      |
| 2018  | 14      |
| 2019  | 20      |
| 2020  | 37      |

</td>
    <td align="center">

| year  | accrual | result |
|:-----:|:-------:|:------:|
| 2015  | 5       | 5      |
| 2016  | 5       | 11     |
| 2017  | 10      | 11     |
| 2018  | 14      | 25     |
| 2019  | 20      | 25     |
| 2020  | 37      | 62     |

</td>
</tr>
</table>

### Задание 2

Необходимо написать запрос, который по таблице с интервалами (Таблица 1) объединит эти интервалы в случае если они пересекаются или граничат.

<table align="center">
<tr>
    <th>Таблица 1. Исходная таблица</th>
    <th>Таблица 2. Результирующая таблица</th>
</tr>
<tr>
    <td align="center">

| start_date | end_date   |
|:----------:|:----------:|
| 2020-01-01 | 2020-01-15 |
| 2020-01-13 | 2020-01-30 |
| 2020-02-01 | 2020-02-05 |
| 2020-02-15 | 2020-02-27 |
| 2020-02-03 | 2020-02-16 |
| 2020-03-01 | 2020-05-04 |
| 2020-06-12 | 2020-06-22 |
| 2020-04-17 | 2020-06-19 |

</td>
    <td align="center">

| start_date | end_date   |
|:----------:|:----------:|
| 2020-01-01 | 2020-01-30 |
| 2020-02-01 | 2020-02-27 |
| 2020-03-01 | 2020-06-22 |

</td>
</tr>
</table>

### Задание 3

Имеется таблица с атрибутами пользователей. Необходимо написать запрос который объединит пользователей в группы по признаку обладания общими атрибутами с выводом списка общих атрибутов для группы (порядок не важен). Если два пользователя не имеют общего атрибута, но попадают в одну группу с одним и тем же третьим пользователем, всех троих нужно объединить в одну группу.

<table align="center">
<tr>
    <th>Таблица 1. Исходная таблица</th>
    <th>Таблица 2. Результирующая таблица</th>
</tr>
<tr>
    <td align="center">

| user_id | attribute           |
|:-------:|:------------------- |
| 1       | "red car"           |
| 1       | "green car"         |
| 2       | "green car"         |
| 2       | "yellow bus"        |
| 3       | "brown cat"         |
| 3       | "black coffeemaker" |
| 4       | "brown cat"         |
| 4       | "purple belt"       |
| 5       | "purple belt"       |
| 5       | "red car"           |
| 6       | "black coffee"      |
| 7       | "black coffee"      |
| 7       | "cow milk"          |
| 8       | "cow milk"          |
| 8       | "tasty croissant"   |

</td>
    <td align="center">

| group_id | user_id | attribute                                                                   |
| :------: | :-----: | :--------                                                                   |
| 1        | 1       | "red car, green car, yellow bus, brown cat, purple belt, black coffeemaker" |
| 1        | 2       | "red car, green car, yellow bus, brown cat, purple belt, black coffeemaker" |
| 1        | 3       | "red car, green car, yellow bus, brown cat, purple belt, black coffeemaker" |
| 1        | 4       | "red car, green car, yellow bus, brown cat, purple belt, black coffeemaker" |
| 1        | 5       | "red car, green car, yellow bus, brown cat, purple belt, black coffeemaker" |
| 2        | 6       | "black coffee, cow milk, tasty croissant"                                   |
| 2        | 7       | "black coffee, cow milk, tasty croissant"                                   |
| 2        | 8       | "black coffee, cow milk, tasty croissant"                                   |


</td>
</tr>
</table>

</div>

---

## Часть 2 (A/B тестирование)

<div style="text-align: justify">

### Постановка задачи
    
Компании поставлена цель – сильно вырастить Monthly Active Users (MAU). При текущем Retention бюджета для достижения цели недостаточно. Для помощи своей команде, ты решил(-а) провести эксперимент - запустить look-alike кампанию на Facebook, чтобы привлечь более качественную аудиторию. Под качеством аудитории понимаеются пользователи, которые продолжают пользоваться приложением спустя месяц (1 Month Retention = 1). Самый большой Churn происходит у пользователей в 0 месяц, поэтому можно грубо ориентироваться только на 1 Month Retention. 

Эксперимент ты решил(-а) провести A/B-тестом – запустить один и тот же креатив на кампанию с использованием look-alike алгоритмов Facebook и тестовую группу без использования дополнительных инструментов, только обычная закупка.

### Задание 1

Для эксперимента, цель которого описана выше, надо подготовить базу новых пользователей, у которых по прогнозу будет высокая активность. Эту базу надо передать менеджерам по закупке трафика, чтобы они использовали ее в look-alike кампании. Решено взять именно новых пользователей, потому что они наилучшим образом отражают целевую аудиторию для закупки здесь и сейчас, а также поведение аудитории на последних версиях приложения обеих платформ (ОС).

Имеется 2 датасэта:
*	[Данные](https://drive.google.com/file/d/1Zp3p2JiiQsWRG7T2ZqABjBChqisoYBAW/view?usp=sharing) по активности в приложении рандомной выборки пользователей за период с 2018-01-01 по 2020-03-26 для обучения модели
*	[Данные](https://drive.google.com/file/d/1Zn6hGe1VJs_EewaIa50DI5LF2qVDWMBR/view?usp=sharing) по активности в приложении новых пользователей за период с 2020-03-01 по 2020-03-25 для прогнозирования

С помощью Python необходимо спрогнозировать для второй выборки активность минимум на 15 дней (без value, только life time). При обучении модели необходимо ориентироваться на достоверность и % ошибки. Выбрать топ 20% пользователей по прогнозной активности. Для них планируется выгрузить идентификаторы для look-alike кампании.

Результаты представить в таком виде:
* График, на котором будет видно фактическую активность пользователей и ту, которую предсказывает модель. Он покажет визуально, насколько хорошо модель обучилась
* На какой период прогнозирует модель
* Ошибка прогноза в количестве событий
* Достоверность прогноза в количестве активных пользователей

### Задание 2

Пришло время подвести итоги эксперимента. Имеются [данные](https://drive.google.com/file/d/1FcqGMpp2x9HIgeOsk5LkPJ0B5O2sry7b/view?usp=sharing) для обеих групп (тестовой и контрольной) по: 

* факту возвращения пользователя в приложение через месяц после его первой сессии (1 Month Retention = 1/0)
* суммарному Revenue пользователя

Для упрощения считаем, что все пользователи пришли примерно в одно время. Необходимо посчитать, какая из двух групп победила по каждому показателю раздельно. С какой вероятностью.

</div>
