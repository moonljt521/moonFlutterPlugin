import 'dart:collection';

class LRUCache<K, V> {
  final int capacity;
  final LinkedHashMap<K, V> cache = LinkedHashMap<K, V>();

  LRUCache(this.capacity);

  V? get(K key) {
    if (!cache.containsKey(key)) {
      return null;
    }

    // 将最近访问的元素移到最前面
    final value = cache.remove(key);
    cache[key] = value as V;
    return value;
  }

  void put(K key, V value) {
    if (cache.containsKey(key)) {
      // 更新已有的元素并移到最前面
      cache.remove(key);
      cache[key] = value;
      return;
    }

    // 如果超出容量，则删除最久未使用的元素
    if (cache.length >= capacity) {
      final oldestKey = cache.keys.first;
      cache.remove(oldestKey);
    }

    // 将新元素插入到最前面
    cache[key] = value;
  }

  void print1() {
    cache.forEach((key, value) {
      print('$key , $value');
    });
  }
}
