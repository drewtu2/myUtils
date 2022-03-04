#pragma once

#include <assert.h>
#include <algorithm> 
#include <list>
#include <map>
#include <string>
#include <unordered_map>

using namespace std;

/**
 * Implement a Time-To-Live, Priority, Least Recently Used Cache.
 * The cache is initialized with a maximum size. Whenever that size is exceeded, items
 * in the cache are ejected in the following order. 
 * 
 * 1. Any expired items are removed.
 * 2. Items of the lowest priority are removed. 
 * 3. Items of the same priority are removed according to the LRU. 
 *
 */

using Priority = int;
using Expiration = int;


struct Entry {
    string key; // The key this is entered as.
    Expiration expiration_time;  // The time this entry expires at. If the current time is greater than this time, the item is considered expired. 
    Priority priority;
    int value; // TODO (atu): Generalize this type.
}

class TtlPriorityLruCache {
  public:
    TtlPriorityLruCache(int max_size) : 
        max_size_{max_size}, 
        current_size_{0}
    {
    }

    void put(const Entry& entry) {
        if(current_size_ >= max_size_) {
            clean();
        }

        // Insert into the overall lookup.
        meta_.insert(make_pair(entry.key, entry));

        // TODO (atu): Replace this with a sorted struct to begin with.
        // Insert into the ttl vector, keep the list sorted.
        expiration_list_.push_back(entry);
        sort(expiration_list_.front(), expiration_list_.end());

        // Create a LRU cache if we need to.
        if(priority_map_.find(entry.priority) == priority_map_.end()) {
            priority_map_.insert(LRUCache());
        }

        priority_map_.at(entry.priority).put(entry.key, entry);
    };
    
    Entry get(const string& key){
        if(!exists(key)) {
            throw runtime_error("Does not exist!");
        }

        const Entry entry = meta_.at(key);
        
        return priority_map_.at(entry.priority).get(key);
    };

    bool exists(const string& key) {
        return meta.find(key) != meta.end();
    }

  private:

    // Cleans out anything that exists that is expired.
    void clean() {
        for(auto entry : expiration_list_) {
            if(IsExpired(entry)) {
                remove(entry);
            }
        }
    };

    bool IsExpired(Entry entry) {
        return CurrentTime() > entry.expiration_time;
    }

    void remove(const Entry& entry) {
    }


    int max_size_;
    int current_size_;

    // Gives me O(1) lookup for an entry. 
    unordered_map<string, Entry> meta_;


    // O(1) lookup for an expired item. 
    // O(N) to remove all expired items.
    vector<Entry> expiration_list_; // Maintain a sorted list based on expiration time. 
    
    // O(lgn) lookup for a priority
    // O(1) lookup within each cache
    // Map is ordered by key.
    map<Priority, LruCache> priority_map_; // Maintain a map of priority queues.

}



template <class KEY_T, class VAL_T> 
class LRUCache {
 public:
  LRUCache(const int cache_size);

  void put(const KEY_T& key, const VAL_T& val);

  bool exist(const KEY_T& key);

  VAL_T get(const KEY_T& key);

 private:
  void clean();
 
 private:
  list< pair<KEY_T,VAL_T> > item_list;
  unordered_map<KEY_T, decltype(item_list.begin()) > item_map;
  size_t cache_size_;
};
