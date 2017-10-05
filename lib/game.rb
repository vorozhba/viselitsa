# encoding: utf-8
#
# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
#
class Game
  def initialize(slovo)
    # Инициализируем переменные экземпляра. В @letters будет лежать массив букв
    # загаданного слова. Для того, чтобы его создать, вызываем метод get_letters
    # этого же класса.
    @letters = get_letters(slovo)

    # Переменная @errors будет хранить текущее количество ошибок, всего можно
    # сделать не более 7 ошибок. Начальное значение — 0.
    @errors = 0

    # Переменные @good_letters и @bad_lettes будут содержать массивы, хранящие
    # угаданные и неугаданные буквы. В начале игры они пустые.
    @good_letters = []
    @bad_letters = []

    # Специальная переменная-индикатор состояния игры (см. метод get_status).
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова.
  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end
    # Сразу приводим слово к нижнему регистру.
    return slovo.downcase.encode('UTF-8').split("")
  end

  # Метод, возвращающий статус игры (геттер для @status)
  #
  #  0 – игра активна
  # -1 – игра закончена поражением
  #  1 – игра закончена победой
  def status
    return @status
  end

  # Основной метод игры "сделать следующий шаг". В качестве параметра принимает
  # букву, которую ввел пользователь.
  def next_step(bukva)
    # Предварительная проверка: если статус игры равен 1 или -1, значит игра
    # закончена и нет смысла дальше делать шаг. Выходим из метода возвращая
    # пустое значение.
    if @status == -1 || @status == 1
      return
    end

    # Если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выходим из метода.
    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end
    # Проверяем введенную букву и ее "подружек" на наличие в слове
    if @letters.include?(bukva) ||
       (bukva == "е" && @letters.include?("ё")) ||
       (bukva == "ё" && @letters.include?("е")) ||
       (bukva == "и" && @letters.include?("й")) ||
       (bukva == "й" && @letters.include?("и"))
      # Если в слове есть буква запишем её в число "правильных" буква. И, если есть, - ее "подружку".
      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      end

      if bukva == "ё"
        @good_letters << "е"
      end

      if bukva == "и"
        @good_letters << "й"
      end

      if bukva == "й"
        @good_letters << "и"
      end

      # Дополнительная проверка — угадано ли на этой букве все слово целиком.
      # Если да — меняем значение переменной @status на 1 — победа.
      if (@letters.uniq.sort - @good_letters.uniq.sort).empty?
        @status = 1
      end
    else
      # Если в слове нет введенной буквы — добавляем эту букву в массив
      # «плохих» букв и увеличиваем счетчик ошибок.
      @bad_letters << bukva
      @errors += 1

      # Если ошибок больше 7 — статус игры меняем на -1, проигрыш.
      if @errors >= 7
        @status = -1
      end
    end
  end

  # Метод, спрашивающий игрока букву и возвращающий ее как результат.
  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      # Сразу приводим букву к нижнему регистру.
      letter = STDIN.gets.downcase.encode("UTF-8").chomp
    end

    # После получения ввода, передаем управление в основной метод игры.
    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
