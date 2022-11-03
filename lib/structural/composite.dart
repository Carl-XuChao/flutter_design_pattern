/// 组合模式（Composite Design Pattern）
/// “组合模式”，主要是用来处理树形结构数据。
/// 实际上，刚才讲的这种组合模式的设计思路，
/// 与其说是一种设计模式，倒不如说是对业务场景的一种数据结构和算法的抽象。
/// 其中，数据可以表示成树这种数据结构，业务需求可以通过在树上的递归遍历算法来实现。

/* e.g
* 假设我们有这样一个需求：设计一个类来表示文件系统中的目录，能方便地实现下面这些功能：
* 动态地添加、删除某个目录下的子目录或文件；
* 统计指定目录下的文件个数；
* 统计指定目录下的文件总大小。
* */

/// 文件和目录用同一个类表示
class FileSystemNodeDefault {
  final String path;

  final bool isFile;

  final double size;

  List<FileSystemNodeDefault> subNodes = [];

  FileSystemNodeDefault(this.path, this.isFile, this.size);

  int countNumOfFiles() {
    if (isFile) {
      return 1;
    }
    int numOfFiles = 0;
    for (FileSystemNodeDefault node in subNodes) {
      numOfFiles += node.countNumOfFiles();
    }
    return numOfFiles;
  }

  double countSizeOfFiles() {
    if (isFile) {
      return size;
    }
    double sizeofFiles = 0;
    for (FileSystemNodeDefault node in subNodes) {
      sizeofFiles += node.countSizeOfFiles();
    }
    return sizeofFiles;
  }

  void addSubNode(FileSystemNodeDefault fileOrDir) {
    subNodes.add(fileOrDir);
  }

  void removeSubNodes(FileSystemNodeDefault fileOrDir) {
    subNodes = subNodes.where((e) => e.path != fileOrDir.path).toList();
  }
}

/// 对文件和目录进行区分设计，定义为 File 和 Directory 两个类。
abstract class FileSystemNode {
  final String path;

  FileSystemNode(this.path);

  int countNumOfFiles();

  double countSizeOfFiles();
}

class File extends FileSystemNode {
  final double size;

  File(super.path, this.size);

  @override
  int countNumOfFiles() {
    return 1;
  }

  @override
  double countSizeOfFiles() {
    return size;
  }
}

class Directory extends FileSystemNode {
  List<FileSystemNode> _subNodes = [];

  Directory(super.path);

  void addSubNode(FileSystemNode fileOrDir) {
    _subNodes.add(fileOrDir);
  }

  void removeSubNode(FileSystemNode fileOrDir) {
    _subNodes = _subNodes.where((e) => e.path != fileOrDir.path).toList();
  }

  @override
  int countNumOfFiles() {
    int numOfFiles = 0;
    for (FileSystemNode node in _subNodes) {
      numOfFiles += node.countNumOfFiles();
    }
    return numOfFiles;
  }

  @override
  double countSizeOfFiles() {
    double sizeofFiles = 0;
    for (FileSystemNode node in _subNodes) {
      sizeofFiles += node.countSizeOfFiles();
    }
    return sizeofFiles;
  }
}

void _main() {
  Directory fileSystemTree = Directory("/");
  Directory node_wz = Directory("/wz/");
  Directory node_xzg = Directory("/xzg/");
  fileSystemTree.addSubNode(node_wz);
  fileSystemTree.addSubNode(node_xzg);

  File node_wz_a = File("/wz/a.txt", 122);
  File node_wz_b = File("/wz/b.txt", 123);
  Directory node_wz_movies = Directory("/wz/movies/");
  node_wz.addSubNode(node_wz_a);
  node_wz.addSubNode(node_wz_b);
  node_wz.addSubNode(node_wz_movies);
  File node_wz_movies_c = File("/wz/movies/c.avi", 34);
  node_wz_movies.addSubNode(node_wz_movies_c);
  Directory node_xzg_docs = Directory("/xzg/docs/");
  node_xzg.addSubNode(node_xzg_docs);
  File node_xzg_docs_d = File("/xzg/docs/d.txt", 56);
  node_xzg_docs.addSubNode(node_xzg_docs_d);
}

/// 组合模式，将一组对象组织成树形结构，将单个对象和组合对象都看做树中的节点，以统一处理逻辑，
/// 并且它利用树形结构的特点，递归地处理每个子树，依次简化代码实现。
/// 使用组合模式的前提在于，你的业务场景必须能够表示成树形结构。
/// 所以，组合模式的应用场景也比较局限，它并不是一种很常用的设计模式。
