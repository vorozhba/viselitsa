# encoding: utf-8
#
# Класс ResultPrinter, печатающий состояние и результаты игры.
#
class ResultPrinter
  def initialize
    # Создадим переменную экземпляра @status_image — массив, хранящий
    # изображения виселиц.
    @status_image = []

    # Сохраним текущее положение файла программы, чтобы с его помощью позже
    # собрать путь к каждой картинке.
    current_path = File.dirname(__FILE__)

    # Создадим переменную для счетчика шагов в цикле
    counter = 0

    # В цикле прочитаем 7 файлов из папки image и запишем из содержимое в массив
    while counter <= 7
      file_name = current_path + "/../image/#{counter}.txt"

      if File.exist?(file_name)
        file = File.new(file_name, "r:UTF-8")
        @status_image << file.read
        file.close
      else
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  # Метод print_viselitsa будет рисовать виселицу, соответствующую текущему
  # количеству ошибок. Единственнй параметро этого метода — целое число errors.
  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  # Основной метод, печатающий состояния объекта класса Game, который нужно
  # передать ему в качестве параметра.
  def print_status(game)
    cls

    puts
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.status == -1
      puts
      puts "Вы проиграли :("
      puts "Загаданное слово было: " + game.letters.join("")
      puts
    elsif game.status == 1
      puts
      puts "Поздравляем, вы выиграли!"
      puts
    else
      puts "У вас осталось ошибок: " + (7 - game.errors).to_s
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    for item in letters do
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end

    return result
  end

  def cls
    system("clear") || system("cls")
  end
end
