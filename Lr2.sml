(* 

fun add (x, y) = x + y;

add (4, 5); *)

type date = int * int * int;
 type test_val = date * date * bool;
 
fun is_older((year_1, month_1, day_1): date, (year_2, month_2, day_2): date) =
    if year_1 < year_2 then
        true
    else if year_1 = year_2 andalso month_1 < month_2 then
        true
    else if year_1 = year_2 andalso month_1 = month_2 andalso day_1 < day_2 then
        true
    else
        false; 
        

    
fun test_is_older() =
    if is_older((2020, 3, 15), (2021, 5, 20)) then 
            print("Тест 1 пройшов успішно.\n")
        else
            print("Тест 1 не пройшов.\n");
    
    if is_older((2022, 6, 25), (2022, 6, 25)) then 
            print("Тест 2 не пройшов.\n")
        else
            print("Тест 2 пройшов успішно.\n");
            
    if is_older((2019, 9, 10), (2019, 9, 15)) then
            print("Тест 3 пройшов успішно.\n")
        else
            print("Тест 3 не пройшов.\n");
            
    if is_older((2023, 12, 20), (2023, 11, 20)) then
            print("Тест 4 не пройшов.\n")
        else
            print("Тест 4 пройшов успішно.\n");

test_is_older();

fun number_in_month(dates: date list, month: int) =
    let
        fun is_month((_, m, _): date) = m = month;
    in
        length (List.filter is_month dates)
    end;

(* test values *)
val test_dates = [
    (2022, 1, 15),
    (2022, 2, 20),
    (2022, 2, 25),
    (2022, 2, 10),
    (2022, 3, 15),
    (2022, 4, 5)
];

val test_res = number_in_month(test_dates, 2);



fun number_in_months(dates: date list, months: int list) =
    let
        fun count_dates_in_months(temp, month) =temp + number_in_month(dates, month)
    in
        List.foldl count_dates_in_months 0 months
    end;

(* test values *)
val test_dates = [
    (2022, 1, 15),
    (2022, 2, 20),
    (2022, 3, 10),
    (2022, 4, 5)
];
val test_mon = [1, 2, 3];
val test_res = number_in_months(test_dates,test_mon);


fun dates_in_month(dates: date list, month: int) =
    let
        fun is_month((_, temp, _): date) = temp = month;
    in
        List.filter is_month dates
    end;

(* test values *)
val test_dates = [
    (2022, 1, 15),
    (2022, 1, 21),
    (2022, 2, 20),
    (2022, 3, 10),
    (2022, 4, 5)
];
val test_res = dates_in_month(test_dates, 1);


fun dates_in_months(dates: date list, months: int list) =
    let
        fun dates_for_month(month: int) = dates_in_month(dates, month);
    in
        List.foldl (op @) [] (List.map dates_for_month months)
    end

(* test values *)
val test_dates = [(2022, 1, 15), (2022, 2, 20), (2022, 3, 25), (2022, 4, 10), (2022, 5, 5)];
val test_mon = [1, 3, 5];
val test_res = dates_in_months(test_dates, test_mon);

val test_dates = [(2022, 1, 15), (2022, 2, 20), (2022, 3, 25), (2022, 4, 10), (2022, 5, 5)];
val test_mon = [0];
val test_res= dates_in_months(test_dates, test_mon);


fun get_nth(lst: int list, n: int): int option =
    if n < 1 then
        NONE
    else if n = 1 then
        SOME (hd lst)
    else
        get_nth(tl lst, n - 1);

(* test values *)
val test_lst = [10, 20, 30, 40, 50];
val test_res= get_nth(test_lst, 3);

val test_lst2 = [1, 3, 5, 7, 9];
val test_res2 = get_nth(test_lst2, 5);

val test_lst3 = [100, 200, 300, 400];
val test_res3 = get_nth(test_lst3, 6);

fun get_nth_list(list: string list, n: int) =
  if n = 1
  then hd list
  else get_nth_list(tl list, n - 1);

fun month_to_string(month: int) =
  let
    val months = [
      "January", 
      "February", 
      "March", 
      "April", 
      "May", 
      "June", 
      "July", 
      "August", 
      "September", 
      "October", 
      "November", 
      "December"
    ]
  in
    get_nth_list(months, month)
  end;

fun date_to_string(date: int*int*int) = 
  let
    val (year, month, day) = date;
in
  month_to_string(month) ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(year)
end

(* test values *)
val example_date = (2022, 3, 15);
val example_string = date_to_string example_date;
  

fun number_before_reaching_sum([], _) = 0           
  | number_before_reaching_sum(numbers, sum) =      
    if hd(numbers) < sum then
      1 + number_before_reaching_sum(tl(numbers), sum - hd(numbers))
    else
      0;

(* test values *)
val test_num = [1, 3, 5, 7, 9];
val test_sum = 10;
val test_res = number_before_reaching_sum(test_num, test_sum);


fun what_month(day_of_year : int) =
    let
        val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(days_in_months, day_of_year)+1
    end;

(* test values *)
val test_day = 100;
val test_month_num = what_month(test_day)

fun months_range(a: int, b: int) =
    let
        fun numbers_range(min: int, max: int) =
            if min <= max then
                min :: numbers_range(min + 1, max)
            else
                []

        fun what_month_range(min_day: int, max_day: int) =
            if min_day > max_day then
                []
            else
                numbers_range(what_month(min_day), what_month(max_day))
    in
        what_month_range(a, b)
    end;

(* test values *)
val test_a = 60;
val test_b = 150;
val test_res = months_range(test_a, test_b);

fun oldest(dates: date list) =
    let
        fun temp(nil, oldest_date) = oldest_date
          | temp(date::rest, oldest_date) =
            if is_older(oldest_date, date) then
                temp(rest, oldest_date)
            else
                temp(rest, date)
    in
        if null dates then
            NONE
        else
            SOME(temp(tl dates, hd dates))
    end;

(* test values *)
val test_d1 = (2022, 3, 15);
val test_d2 = (2023, 5, 20);
val test_d3 = (2022, 3, 10);

val test_12 = is_older(test_d1, test_d2);
val test_13 = is_older(test_d1, test_d3);
val test_23 = is_older(test_d2, test_d3);
