# 1. Найти сумму всех чётных чисел от 1 до N
n = int(input("введите N: "))  # Получаем число от пользователя и преобразуем его в целое число

def sum_even(n):
    total = 0  # Инициализируем переменную для хранения суммы чётных чисел
    for i in range(2, n + 1, 2):  # Перебираем числа от 2 до n с шагом 2 (то есть только чётные)
        total += i  # Прибавляем каждое чётное число к переменной total
    return total  # Возвращаем итоговую сумму

print("сумма всех чётных чисел от 1 до", n, "равна:", sum_even(n))  # Выводим результат



# 2. Проверка, является ли строка палиндромом
s = input("введите строку: ")  # Получаем строку от пользователя

def is_palindrome(s):
    return s == s[::-1]  # Сравниваем строку с её обратной версией (срез с шагом -1)

if is_palindrome(s):  # Если функция возвращает True — строка палиндром
    print("строка является палиндромом")
else:
    print("строка не является палиндромом")



# 3. Создать словарь из строки: ключ - символ, значение - количество повторений
text = input("введите строку: ")  # Вводим строку

def count_chars(text):
    d = {}  # Создаём пустой словарь для хранения символов и их количества
    for c in text:  # Перебираем каждый символ строки
        if c in d:  # Если символ уже есть в словаре
            d[c] += 1  # Увеличиваем счётчик на 1
        else:
            d[c] = 1  # Если символ встречается впервые, добавляем его со значением 1
    return d  # Возвращаем словарь с результатами

print(count_chars(text))  # Выводим результат



# 4. Факториал числа
x = int(input("введите число: "))  # Получаем число от пользователя

def factorial(x):
    f = 1  # Начальное значение факториала (1, потому что умножение)
    for i in range(2, x + 1):  # Перебираем числа от 2 до x
        f *= i  # Умножаем текущее значение на i
    return f  # Возвращаем вычисленный факториал

print("факториал:", factorial(x))  # Выводим результат



# 5. Отсортировать список слов по длине
words = input("введите слова через пробел: ").split()  # Получаем строку, разделяем её по пробелам, превращаем в список слов

def sort_by_length(words):
    words.sort(key=len)  # Сортируем список по длине каждого слова (ключ сортировки — функция len)
    return words  # Возвращаем отсортированный список

print(sort_by_length(words))  # Печатаем результат



# 6. Удалить дубликаты из списка и вернуть новый список
lst = input("введите элементы списка через пробел: ").split()  # Вводим элементы и разбиваем строку на список

def remove_duplicates(lst):
    result = []  # Создаём новый список для хранения уникальных значений
    for item in lst:  # Перебираем каждый элемент исходного списка
        if item not in result:  # Если элемент ещё не добавлен в результат
            result.append(item)  # Добавляем его
    return result  # Возвращаем список без дубликатов

print(remove_duplicates(lst))  # Выводим результат


# 7. Список квадратов нечётных чисел от 1 до 20
def odd_squares():
    result = []  # Список для хранения квадратов
    for i in range(1, 21):  # Перебираем числа от 1 до 20
        if i % 2 == 1:  # Проверяем, является ли число нечётным
            result.append(i * i)  # Если да — добавляем его квадрат в список
    return result  # Возвращаем список квадратов

print(odd_squares())  # Печатаем результат



# 8. Генератор списка строк длиной больше 3 символов
strings = ['собака', 'кошка', 'птица', 'рыба']  # Исходный список строк

def filter_long_strings(strings):
    result = []  # Список для хранения строк длиной больше 3
    for s in strings:  # Перебираем каждую строку
        if len(s) > 3:  # Если длина строки больше 3 символов
            result.append(s)  # Добавляем в результат
    return result  # Возвращаем отфильтрованный список

print(filter_long_strings(strings))  # Выводим результат


# 9. Класс Rectangle с методами area и perimeter
class Rectangle:
    def __init__(self, width, height):  # Конструктор класса, принимает ширину и высоту
        self.width = width  # Сохраняем ширину в атрибут
        self.height = height  # Сохраняем высоту в атрибут

    def area(self):  # Метод для вычисления площади
        return self.width * self.height  # Ширина × высота

    def perimeter(self):  # Метод для вычисления периметра
        return 2 * (self.width + self.height)  # 2 × (ширина + высота)

r = Rectangle(5, 7)  # Создаём объект прямоугольника с размерами 5 и 7
print("площадь:", r.area())  # Выводим площадь
print("периметр:", r.perimeter())  # Выводим периметр



# 10. Класс Student с атрибутами имя, оценки и средняя оценка
class Student:
    def __init__(self, name, grades):  # Конструктор класса, принимает имя и список оценок
        self.name = name  # Сохраняем имя
        self.grades = grades  # Сохраняем список оценок

    def average(self):  # Метод для подсчёта средней оценки
        total = 0  # Инициализируем сумму
        for g in self.grades:  # Проходим по каждой оценке
            total += g  # Прибавляем к сумме
        if len(self.grades) == 0:  # Если оценок нет — возвращаем 0
            return 0
        return total / len(self.grades)  # Возвращаем среднее значение

s = Student("никита", [4, 5, 3, 4])  # Создаём объект студента
print("средняя оценка студента", s.name, "=", s.average())  # Выводим среднюю оценку



# 11. Класс BankAccount с методами deposit и withdraw
class BankAccount:
    def __init__(self):  # Конструктор без параметров
        self.balance = 0  # Начальный баланс по счёту — 0

    def deposit(self, amount):  # Метод для пополнения счёта
        self.balance += amount  # Увеличиваем баланс на указанную сумму

    def withdraw(self, amount):  # Метод для снятия средств
        if amount <= self.balance:  # Проверка: хватает ли денег на счёте
            self.balance -= amount  # Уменьшаем баланс
            return True  # Возвращаем True, если операция успешна
        else:
            return False  # Возвращаем False, если денег недостаточно

acc = BankAccount()  # Создаём экземпляр банковского счёта
acc.deposit(1000)  # Вносим 1000
print("баланс после депозита:", acc.balance)  # Проверяем баланс

success = acc.withdraw(500)  # Пытаемся снять 500
print("снятие 500:", success)  # Проверяем, успешно ли
print("баланс после снятия:", acc.balance)  # Баланс после снятия



# 12. Считать текст из файла и посчитать строки и слова
with open("file.txt", "w", encoding="utf-8") as f:  # Открываем файл на запись (создаётся/перезаписывается)
    f.write("привет\nпривет1 \nпривет2\n")  # Записываем строки в файл

with open("file.txt", "r", encoding="utf-8") as f:  # Открываем файл на чтение
    lines_count = 0  # Счётчик строк
    words_count = 0  # Счётчик слов
    for line in f:  # Читаем построчно
        lines_count += 1  # Увеличиваем счётчик строк
        words_count += len(line.split())  # Считаем количество слов в строке и добавляем

print("количество строк:", lines_count)  # Выводим количество строк
print("количество слов:", words_count)  # Выводим количество слов



# 13. Удалить из списка все элементы меньше заданного числа
lst = input("введите числа через пробел: ").split()  # Вводим числа строкой и разбиваем по пробелам
threshold = int(input("введите порог: "))  # Вводим пороговое значение

def filter_greater_or_equal(lst, threshold):
    result = []  # Список для хранения подходящих чисел
    for item in lst:  # Перебираем все элементы списка
        if int(item) >= threshold:  # Если число не меньше порога
            result.append(int(item))  # Добавляем в результат, преобразуя в число
    return result  # Возвращаем отфильтрованный список

print(filter_greater_or_equal(lst, threshold))  # Печатаем результат



# 14. Простой калькулятор с операциями +, -, *, /
a = int(input("введите первое число: "))  # Вводим первое число
b = int(input("введите второе число: "))  # Вводим второе число
op = input("введите операцию (+, -, *, /): ")  # Вводим оператор

if op == '+':
    print("Результат:", a + b)  # Сложение
elif op == '-':
    print("Результат:", a - b)  # Вычитание
elif op == '*':
    print("Результат:", a * b)  # Умножение
elif op == '/':
    if b == 0:  # Проверка деления на ноль
        print("Ошибка: деление на ноль!")
    else:
        print("Результат:", a / b)  # Деление
else:
    print("Неизвестная операция")  # Ошибка, если операция некорректна



# 15. Список из 10 случайных чисел и нахождение максимума и минимума
import random  # Импортируем модуль random

numbers = []  # Список для хранения случайных чисел
for i in range(10):  # 10 раз генерируем число
    numbers.append(random.randint(1, 100))  # Добавляем случайное число от 1 до 100

max_num = numbers[0]  # Начальное значение для поиска максимума
min_num = numbers[0]  # Начальное значение для поиска минимума

for num in numbers:  # Перебираем числа в списке
    if num > max_num:  # Если текущее больше максимального — обновляем
        max_num = num
    if num < min_num:  # Если текущее меньше минимального — обновляем
        min_num = num

print("Список чисел:", numbers)  # Печатаем список
print("Максимум:", max_num)  # Печатаем максимум
print("Минимум:", min_num)  # Печатаем минимум


# 16 Кортеж из 5 элементов, вывести в обратном порядке
t = (1, 2, 3, 4, 5)  # Создаём кортеж из 5 чисел
print("1)", t[::-1])  # Срез с шагом -1 — переворачиваем порядок элементов


# 17 Сравнить два словаря, вывести общие ключи
dict1 = {'a': 1, 'b': 2, 'c': 3}  # Первый словарь
dict2 = {'b': 4, 'c': 5, 'd': 6}  # Второй словарь

# Список ключей, которые есть и в dict1, и в dict2
common_keys = [k for k in dict1 if k in dict2]

print("2) Общие ключи:", common_keys)  # Печатаем результат


# 18 Django 
# Создание проекта Django в терминале:
# django-admin startproject myproject  — создаёт новый проект Django
# cd myproject                         — переходим в папку проекта
# python manage.py startapp main      — создаём приложение с именем main

# В файле myproject/urls.py нужно добавить маршрут:
# from django.urls import path
# from main.views import home
# urlpatterns = [path('', home)]  — подключаем представление home по корневому адресу

# В файле main/views.py создаём представление:
# from django.http import HttpResponse
# def home(request):
#     return HttpResponse("Hello, World!")  — простая текстовая страница

# Запуск сервера:
# python manage.py runserver  — запускаем локальный веб-сервер


# 19 Окно с заголовком и кнопкой "Закрыть" (Tkinter)
import tkinter as tk  # Импорт библиотеки для создания GUI

def window_with_close():
    root = tk.Tk()  # Создаём главное окно
    root.title("Окно")  # Устанавливаем заголовок окна

    # Создаём кнопку с надписью "Закрыть", при нажатии вызывается root.destroy()
    btn = tk.Button(root, text="Закрыть", command=root.destroy)
    btn.pack(padx=20, pady=20)  # Размещаем кнопку с отступами

    root.mainloop()  # Запускаем главный цикл обработки событий

window_with_close()  # Вызываем функцию

# 20 Форма с Имя, Фамилия и кнопкой "Сохранить" (Tkinter)
import tkinter as tk  # Импорт библиотеки Tkinter

def form_name_surname():
    def save():  # Вложенная функция, вызываемая при нажатии кнопки
        print("Имя:", entry_name.get())  # Получаем и выводим значение из поля "Имя"
        print("Фамилия:", entry_surname.get())  # Получаем и выводим значение из поля "Фамилия"

    root = tk.Tk()  # Создаём главное окно
    root.title("Форма")  # Заголовок окна

    tk.Label(root, text="Имя").pack()  # Надпись "Имя"
    entry_name = tk.Entry(root)  # Поле ввода имени
    entry_name.pack()

    tk.Label(root, text="Фамилия").pack()  # Надпись "Фамилия"
    entry_surname = tk.Entry(root)  # Поле ввода фамилии
    entry_surname.pack()

    btn = tk.Button(root, text="Сохранить", command=save)  # Кнопка, при нажатии вызывает save()
    btn.pack(pady=10)

    root.mainloop()  # Запуск интерфейса

form_name_surname()  # Запуск функции


# 21 Таймер обратного отсчёта (Tkinter)
import tkinter as tk  # Импортируем модуль Tkinter для создания GUI

def countdown_timer():
    def countdown(count):  # Вложенная функция таймера
        label['text'] = count  # Отображаем текущее значение счётчика
        if count > 0:  # Если счётчик ещё не дошёл до 0
            root.after(1000, countdown, count-1)  # Запускаем себя снова через 1000 мс (1 секунда)

    root = tk.Tk()  # Создаём главное окно
    root.title("Таймер")  # Устанавливаем заголовок

    label = tk.Label(root, font=('Arial', 48))  # Создаём метку для отображения числа
    label.pack()  # Размещаем метку

    countdown(10)  # Запускаем обратный отсчёт с 10

    root.mainloop()  # Запускаем интерфейс


# 21 Рисование фигур на Canvas (Tkinter)
import tkinter as tk  # Импортируем Tkinter

def draw_figures():
    root = tk.Tk()  # Главное окно
    root.title("Рисование")  # Заголовок окна

    canvas = tk.Canvas(root, width=300, height=300, bg='white')  # Создаём холст 300x300
    canvas.pack()  # Размещаем холст в окне

    canvas.create_rectangle(50, 50, 150, 150, fill='blue')  # Прямоугольник: координаты и цвет
    canvas.create_oval(160, 50, 260, 150, fill='red')  # Овал (эллипс)
    canvas.create_line(50, 200, 250, 200, width=3)  # Линия

    root.mainloop()  # Запуск интерфейса

draw_figures()  # Запускаем функцию


# 22 To-Do список
import tkinter as tk  # Импорт библиотеки Tkinter

def todo_list():
    def add_task():  # Добавить задачу
        task = entry.get()  # Получаем текст из поля ввода
        if task:
            listbox.insert(tk.END, task)  # Добавляем задачу в список
            entry.delete(0, tk.END)  # Очищаем поле

    def delete_task():  # Удалить выбранную задачу
        selected = listbox.curselection()  # Получаем индексы выбранных элементов
        for index in reversed(selected):  # Удаляем с конца, чтобы не нарушить порядок
            listbox.delete(index)

    root = tk.Tk()  # Главное окно
    root.title("To-Do")  # Заголовок

    entry = tk.Entry(root)  # Поле ввода задачи
    entry.pack(padx=10, pady=5)

    btn_add = tk.Button(root, text="Добавить", command=add_task)  # Кнопка "Добавить"
    btn_add.pack(padx=10, pady=5)

    btn_del = tk.Button(root, text="Удалить", command=delete_task)  # Кнопка "Удалить"
    btn_del.pack(padx=10, pady=5)

    listbox = tk.Listbox(root, selectmode=tk.MULTIPLE)  # Список с множественным выбором
    listbox.pack(padx=10, pady=5)

    root.mainloop()  # Запускаем интерфейс

todo_list()  # Запускаем приложение



# 23 Выпадающий список ComboBox (Tkinter)
import tkinter as tk  # Импорт библиотеки Tkinter
from tkinter import ttk  # Импорт подмодуля ttk (современные виджеты)

def combo_cities():
    root = tk.Tk()  # Главное окно
    root.title("Выбор города")  # Заголовок окна

    combo = ttk.Combobox(root, values=["Москва", "Питер", "Вена"])  # Выпадающий список
    combo.pack(padx=10, pady=10)  # Размещение с отступами
    combo.current(0)  # Устанавливаем значение по умолчанию (первый элемент)

    root.mainloop()  # Запускаем GUI

combo_cities()  # Запускаем приложение

# 24 Форма авторизации с логином и паролем (Tkinter)
import tkinter as tk  # Импорт библиотеки Tkinter

def login_form():
    def login():  # Действие при нажатии кнопки "Войти"
        print("Логин:", entry_login.get())  # Получаем логин
        print("Пароль:", entry_password.get())  # Получаем пароль

    root = tk.Tk()  # Главное окно
    root.title("Авторизация")  # Заголовок окна

    tk.Label(root, text="Логин").pack()  # Метка "Логин"
    entry_login = tk.Entry(root)  # Поле ввода логина
    entry_login.pack()

    tk.Label(root, text="Пароль").pack()  # Метка "Пароль"
    entry_password = tk.Entry(root, show="*")  # Поле ввода пароля (звёздочки)
    entry_password.pack()

    btn = tk.Button(root, text="Войти", command=login)  # Кнопка входа
    btn.pack(pady=10)

    root.mainloop()  # Запуск интерфейса

login_form()  # Запуск функции


# 25 Преобразовать список в строку через запятую
lst = ['яблоко', 'банан', 'вишня']  # Исходный список

def list_to_string(lst):
    return ', '.join(lst)  # Объединяем все элементы списка в строку через запятую

print("11)", list_to_string(lst))  # Печатаем результат


# 26 Считать файл и найти самое длинное слово
# Открываем файл на запись и добавляем несколько строк
with open("file.txt", "w", encoding="utf-8") as f:
    f.write("jwehwyughdsiun\nгодот\nкууууууууууууууууууууу")

# Открываем файл на чтение
with open("file.txt", "r", encoding="utf-8") as f:
    words = []  # Список для хранения всех слов
    for line in f:  # Перебираем строки файла
        words.extend(line.split())  # Разделяем строку на слова и добавляем в список

longest = ''  # Переменная для самого длинного слова
for w in words:  # Перебираем все слова
    if len(w) > len(longest):  # Если текущее слово длиннее предыдущего
        longest = w  # Обновляем самое длинное слово

print("Самое длинное слово:", longest)  # Выводим результат


# 27 Меню с пунктами "Файл", "Справка", "Выход" (Tkinter)
import tkinter as tk  # Импортируем Tkinter
from tkinter import messagebox  # Импорт окна сообщений

def menu_example():
    def show_help():
        messagebox.showinfo("Справка", "Это простое меню")  # Показываем окно справки

    def exit_app():
        root.destroy()  # Закрытие приложения

    root = tk.Tk()  # Создаём главное окно
    root.title("Меню")  # Заголовок окна

    menubar = tk.Menu(root)  # Создаём панель меню

    # Создаём выпадающее меню "Файл"
    filemenu = tk.Menu(menubar, tearoff=0)  # tearoff=0 отключает отрывное меню
    filemenu.add_command(label="Выход", command=exit_app)  # Пункт меню "Выход"
    menubar.add_cascade(label="Файл", menu=filemenu)  # Добавляем выпадающее меню в панель

    # Создаём выпадающее меню "Справка"
    helpmenu = tk.Menu(menubar, tearoff=0)
    helpmenu.add_command(label="Справка", command=show_help)  # Пункт меню "Справка"
    menubar.add_cascade(label="Справка", menu=helpmenu)  # Добавляем его в панель

    root.config(menu=menubar)  # Привязываем меню к окну

    root.mainloop()  # Запускаем главный цикл

menu_example()  # Запуск интерфейса
