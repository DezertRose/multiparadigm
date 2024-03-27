// Lr1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
using namespace std;

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>


int main(){
    ifstream input_file("test.txt");
    // string help_str;
    string cur_word;
    vector<pair<string, int>> words_cnt_list;
    vector<string> stop_word = { "the", "for", "and", "or", "is", "are", "in", "on", "to", "if", "a", "be"};
    int output_numb = 25;
    int i = 0;
    int max_i = 0;
    int max_cnt = 0;
    int j = 0;

    if(!input_file.is_open()) {

        cerr << "Can't open the file!" << endl;
        return 1;
    }    

COUNT_WORD:

    input_file >> cur_word;

    if(!input_file.eof()){
      
        transform(cur_word.begin(), cur_word.end(), cur_word.begin(), ::tolower);
        
        if(find(stop_word.begin(), stop_word.end(), cur_word) != stop_word.end()){
            goto COUNT_WORD;
        }

        auto it = find_if(words_cnt_list.begin(), words_cnt_list.end(), [&cur_word](const pair<string, int>& temp){

            if (temp.first == cur_word){
                return true;
            }
            else {
                return false;
            }
             
        });

        if(it != words_cnt_list.end()){

            it->second++;
        }
        else{

            words_cnt_list.push_back({cur_word, 1});
        }

        goto COUNT_WORD;
    }

   
SORT:
    if(i < words_cnt_list.size()){
        int max_i = i;
        int max_cnt = words_cnt_list[i].second;
        int j = i + 1;

     FIND_MAX_WORD:
        if (j < words_cnt_list.size()){
            if (words_cnt_list[j].second > max_cnt) {
                max_i = j;
                max_cnt = words_cnt_list[j].second;
            }
            j++;
            goto FIND_MAX_WORD;
        }

        swap(words_cnt_list[i], words_cnt_list[max_i]);

        cout << words_cnt_list[i].first << ": " << words_cnt_list[i].second << endl;
        i++;
        goto SORT;
    }


    input_file.close();
    return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
