# frozen_string_literal: true

require 'date'

# класс цепочки периодов
class PeriodsChain
  # конструктор
  def initialize(start_date, chain)
    @start_date = start_date.split('.').collect(&:to_i).reverse
    @chain = chain.map { |c| convert_period(c) }
  end

  # метод проверки корректности цепочки
  def valid?
    return false if @chain.nil? || @start_date.nil? || (@start_date <=> @chain[0]).eql?(-1)

    # смещение по дню
    offset = @start_date[2]
    @chain.each do |elem|
      return false unless compare_dates(@start_date, elem)

      tmp = case elem.length
            when 1
              annually(@start_date)
            when 2
              monthly(@start_date, offset)
            when 3
              daily(@start_date)
            end

      offset = tmp[2] if elem.length == 3
      @start_date = tmp
    end

    true
  end

  # метод добавления нового элемента в цепочку
  def add(_new_period_type)
    last_date = type(@start_date, convert_period(@chain[-1]))

    case type
    when 'annually'
      @chain << last_date[0].to_s
    when 'monthly'
      @chain << "#{last_date[0]}M#{last_date[1]}"
    when 'daily'
      @chain << "#{last_date[0]}M#{last_date[1]}D#{last_date[2]}"
    end
  end

  private

  # сравнение двух дат
  def compare_dates(date_arr1, date_arr2)
    if date_arr1.length > date_arr2.length then !(date_arr1 <=> date_arr2).eql?(-1)
    elsif date_arr1.length < date_arr2.length
      !(date_arr2 <=> date_arr1).eql?(-1)
    else
      date_arr1.eql? date_arr2
    end
  end

  def type(start_date, period)
    case period.length
    when 1
      start_date[0] = period[0]
      annually(start_date)
    when 2
      period << start_date[2]
      monthly(period)
    when 3
      daily(period)
    end
  end

  # конвертация исходящей цепочки
  def convert_period(period)
    period.gsub(/[DM]/, ' ').split.map(&:to_i)
  end

  # типы периодов
  # дневной
  def daily(date_arr)
    convert_date(Date.new(date_arr[0], date_arr[1], date_arr[2]).next_day)
  end

  # месячный
  def monthly(date_arr, offset)
    return [date_arr[0], date_arr[1] + 1, offset] if Date.valid_date?(date_arr[0], date_arr[1] + 1, offset)

    convert_date(Date.new(date_arr[0], date_arr[1], date_arr[2]).next_month)
  end

  # годовой
  def annually(date_arr)
    convert_date(Date.new(date_arr[0], date_arr[1], date_arr[2]).next_year)
  end

  # конвертация даты в целочисленный массив
  # избежание дублирования кода
  def convert_date(date)
    date.to_s.split('-').map(&:to_i)
  end
end
