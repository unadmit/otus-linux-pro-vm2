# otus-linux-pro-vm2
Вирутальная машина создаётся с 4 дисками и выполняет провижн со следующими шагами:
1. Установка утилит.
2. Определение свободного диска.
3. Выбор диска для дальнейшего отключения.
4. Создание RAID 5.
5. Определение свободного от RAID-массива диска.
6. Создание загрузочного раздела.
7. Создание 5 разделов с созданием файловой системы, их монтированием и записи в fstab.
8. Создание конфигурационного файла mdadm.
9. Ожидание завершения инициализации RAID-массива. Установка диска из п.3 в статус fail.
10. Удаление из RAID-массива диска.
11. Добавление в RAID-массив свободного диска из п.2. Ожидание завершения.
12. Установка диска из п.2 в статус fail.
13. Удаление диска из RAID-массива.
14. Возвращение диска из п.3 в RAID-массив.
