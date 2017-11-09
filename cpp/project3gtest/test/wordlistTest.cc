#include <vector>
#include <string>

#include "wordlist.h"
#include "gtest/gtest.h"



TEST(Wordlist, constructor) {
  wordList myList("test_words.txt");
  std::vector<std::string> myVec = {"hello", "world", "bob", "and", "alice"};

  EXPECT_EQ(5, myList.getSize());
  
  for(int ii = 0; ii < myList.getSize(); ++ii)
  {
    EXPECT_EQ(myVec[ii], myList.get(ii));
  }

}

