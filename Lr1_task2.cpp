// Lr1_task2.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

using namespace std;

#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>

int main() {
    ifstream input_file("test.txt");
    map<string, vector<int>> word_page;
    map<string, int> word_cnt;
    string currentWord;
    string cur_word;
    int page_cnt = 1;
    int line_cnt = 0;
    int i = 0;
    int p_size = 0;

    if (!input_file.is_open()) {

        cerr << "Can't open the file!" << endl;
        return 1;
    }

read_next_word:
    input_file >> cur_word;

    if (input_file.eof()) {
        goto RESULT;
    }

    if (++line_cnt > 45) {
        page_cnt++;
        line_cnt = 1;
    }

    if(word_cnt.find(cur_word) != word_cnt.end()) {
        word_cnt[cur_word]++;
    }
    else {
        word_cnt[cur_word] = 1;
    }

    if (word_page.find(cur_word) != word_page.end()) {

        if (find(word_page[cur_word].begin(), word_page[cur_word].end(), page_cnt) == word_page[cur_word].end()) {
            word_page[cur_word].push_back(page_cnt);
        }
    }
    else {
        word_page[cur_word] = { page_cnt };
    }

    goto read_next_word;

RESULT:
    auto temp = word_page.begin();
PRINT:
    if (temp == word_page.end()) { 
        goto END; 
    }

    currentWord = temp->first;


    if (word_cnt[currentWord] <= 100) {
        cout << temp->first << ": ";
        vector<int>& pages = temp->second;
        i = 0;
        p_size = pages.size();
    PAGE_CNT_OUT:
        if (i >= p_size) goto NEXT_WORD;
        cout << pages[i] << " ";
        i++;
        goto PAGE_CNT_OUT;
    }
NEXT_WORD:
    ++temp;
    cout << endl;
    goto PRINT;

END:
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
