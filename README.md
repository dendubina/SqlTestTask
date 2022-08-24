Предметная область: банковская сфера.
 - У одного банка могут быть филиалы в нескольких городах. В одном городе может быть несколько филиалов
 - В одном банке у клиента может быть только один аккаунт (аналог расчетного счета в реальных банках)
 - К каждому аккаунту может быть привязано несколько карточек. Также могут быть аккаунты БЕЗ карточек.
 - У каждого клиента обязательно должен быть ОДИН соц статус.
 
 Задания
 1. Покажи мне список банков у которых есть филиалы в городе X (выбери один из городов)
 2. Получить список карточек с указанием имени владельца, баланса и названия банка
 3. Показать список банковских аккаунтов у которых баланс не совпадает с суммой баланса по карточкам. В отдельной колонке вывести разницу
 4. Вывести кол-во банковских карточек для каждого соц статуса (2 реализации, GROUP BY и подзапросом)
 5. Написать stored procedure которая будет добавлять по 10$ на каждый банковский аккаунт для определенного соц статуса (У каждого клиента бывают разные соц. статусы. Например, пенсионер, инвалид и прочее). Входной параметр процедуры - Id социального статуса. Обработать исключительные ситуации (например, был введен неверные номер соц. статуса. Либо когда у этого статуса нет привязанных аккаунтов).
 6. Получить список доступных средств для каждого клиента. То есть если у клиента на банковском аккаунте 60 рублей, и у него 2 карточки по 15 рублей на каждой, то у него доступно 30 рублей для перевода на любую из карт
 7. Написать процедуру которая будет переводить определённую сумму со счёта на карту этого аккаунта.  При этом будем считать что деньги на счёту все равно останутся, просто сумма средств на карте увеличится. Например, у меня есть аккаунт на котором 1000 рублей и две карты по 300 рублей на каждой. Я могу перевести 200 рублей на одну из карт, при этом баланс аккаунта останется 1000 рублей, а на картах будут суммы 300 и 500 рублей соответственно. После этого я уже не смогу перевести 400 рублей с аккаунта ни на одну из карт, так как останется всего 200 свободных рублей (1000-300-500). Переводить БЕЗОПАСНО. То есть использовать транзакцию
 8. Написать триггер на таблицы Account/Cards чтобы нельзя была занести значения в поле баланс если это противоречит условиям  (то есть нельзя изменить значение в Account на меньшее, чем сумма балансов по всем карточкам. И соответственно нельзя изменить баланс карты если в итоге сумма на картах будет больше чем баланс аккаунта)

