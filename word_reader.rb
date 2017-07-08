# encoding: utf-8
#
# Класс WordReader, отвечающий за чтение слова для игры.
#
class WordReader
  #  Можно использовать возможность читать загаданное слово из командной строки вместо файла со словами.
  def read_from_args
    return ARGV[0]
  end

  # Метод read_from_file, возвращающий случайное слово, прочитанное из файла.
  def read_from_file(file_name)
    # Если файла не существует, сразу выходим из метода.
    if !File.exist?(file_name)
      return nil
    end

    # Открываем файл, явно указывая его кодировку, читаем все строки в массив и
    # закрываем файл.
    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close

    # Возвращаем случайную строчку (слово) из прочитанного массива.
    return lines.sample.chomp
  end
end
