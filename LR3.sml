fun same_string(s1 : string, s2 : string) =
    s1 = s2;

fun all_except_option(str : string, lst : string list) =
    let
        fun remove_string ([], _) = NONE
          | remove_string (x::xs, temp) =
            if same_string(x, str)
               then SOME (temp @ xs)
                  else remove_string (xs, temp @ [x])
    in
        remove_string (lst, [])
    end

fun get_substitutions1(sub_list: string list list, s: string) =
    let
        fun in_str([], _) = false
          | in_str(x::xs, temp) =
            if x = temp 
              then true 
                else in_str(xs, temp)
  
        fun list_filter([], _) = []
          | list_filter(x::xs, temp) =
            if x = temp 
              then list_filter(xs, temp)
              else x :: list_filter(xs, temp)

        fun filt_str([], acc) = acc
          | filt_str(subList::res, acc) =
            if in_str(subList, s)
            then filt_str(res, list_filter(subList, s) @ acc)
            else filt_str(res, acc)
    in
        filt_str(sub_list, [])
    end

fun get_substitutions2(sub_list: string list list, s: string) =
    let
        fun in_str([], _) = false
          | in_str(x::xs, temp) =
            if x = temp 
              then true 
                else in_str(xs, temp)
  
        fun list_filter([], _, acc) = acc
          | list_filter(x::xs, temp, acc) =
            if x = temp 
              then list_filter(xs, temp, acc)
              else list_filter(xs, temp, x::acc)

        fun filt_str([], acc) = acc
          | filt_str(subList::res, acc) =
            if in_str(subList, s)
            then filt_str(res, list_filter(subList, s, []) @ acc)
            else filt_str(res, acc)
    in
        filt_str(sub_list, [])
    end;

fun similar_names (substitutions, { 
  first = first_name, 
  sec = middle_name, 
  last = surname
}) =
  let
    fun to_name(name) = { 
      first =  name, 
      sec = middle_name, 
      last = surname 
    };

    fun gen_names([], acc) = acc
      | gen_names(x::xs, acc) =
        gen_names(xs, acc @ [to_name x])
  in
    gen_names (
      get_substitutions1(substitutions, first_name),
      [to_name first_name]
    )
end;


datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color(card: card) =
    case card of
        (Clubs, _) => Black
      | (Spades, _) => Black
      | (Hearts, _) => Red
      | (Diamonds, _) => Red;

fun card_value((_, rank): card) =
    case rank of
        Num n => n
      | Ace => 11
      | _ => 10;

fun remove_card(cs: card list, c: card, e: exn) =
    let
        fun remove([], _) = raise e
          | remove(x::xs, c) =
            if x = c then
                xs
            else
                x :: remove(xs, c)
    in
        remove(cs, c)
    end;

fun all_same_color(cards: card list) =
    let
        fun temp([]) = true
          | temp([_]) = true
          | temp(card1 :: card2 :: rest) =
            if card_color card1 = card_color card2 then
                temp(card2 :: rest)
            else
                false
    in
        temp cards
    end;

fun sum_cards(cards: card list) =
    let
        fun temp([], acc) = acc
          | temp(card :: res, acc) =
            temp(res, acc + card_value( card))
    in
        temp(cards, 0)
    end;

fun score(cards: card list, goal: int) =
    let
        val sum = sum_cards cards
        val same_color = all_same_color cards

        val score_befor =
            if sum > goal 
               then  3 * (sum - goal)
            else goal - sum       

        val res_score =
            if same_color 
               then score_befor div 2
            else score_befor
    in
        res_score
    end;

    fun is_card([], _) = false
  | is_card(x::xs, c) =
    case x of
        card => if card = c then true else is_card(xs, c)

fun officiate(cards: card list, moves: move list, goal: int) =
    let
        fun play(cards: card list, player_cards: card list, moves: move list): int =
            case moves of
                [] => score(player_cards, goal)  
              | Discard(c) :: rest_moves =>
                if is_card(player_cards, c) then
                    let
                        val player_cards_n = remove_card(player_cards, c, IllegalMove)
                    in
                        if sum_cards(player_cards_n) > goal then
                            score(player_cards_n, goal)
                        else
                            play(cards, player_cards_n, rest_moves)
                    end
                else
                    raise IllegalMove
              | Take :: rest_moves =>
                case cards of
                    [] => score(player_cards, goal) 
                  | x::xs =>
                    let
                        val player_cards_n = x :: player_cards
                        val new_sum = sum_cards player_cards_n
                    in
                        if new_sum > goal then
                            score(player_cards_n, goal)
                        else
                            play(xs, player_cards_n, rest_moves)
                    end
    in
        play(cards, [], moves)
    end;

