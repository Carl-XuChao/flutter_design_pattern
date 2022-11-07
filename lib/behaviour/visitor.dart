/// 访问者者模式(Visitor Design Pattern)
/// 允许一个或者多个操作应用到一组对象上，解耦操作和对象本身。

abstract class ResourceFile {
  final String filePath;

  ResourceFile(this.filePath);

  void accept(Visitor visitor);
}

abstract class Visitor {
  // void visit(PdfFile file);
  // void visit(WordFile file);
  // void visit(PPTFile file);

  /// flutter 没法实现上面的函数重载， 使用可选参数代替
  void visit(ResourceFile file);
}

class PdfFile extends ResourceFile {
  PdfFile(super.filePath);

  @override
  void accept(Visitor visitor) {
    visitor.visit(this);
  }
}

class WordFile extends ResourceFile {
  WordFile(super.filePath);

  @override
  void accept(Visitor visitor) {
    visitor.visit(this);
  }
}

class PPTFile extends ResourceFile {
  PPTFile(super.filePath);

  @override
  void accept(Visitor visitor) {
    visitor.visit(this);
  }
}

/// 解压类
class Extractor implements Visitor {
  @override
  void visit(ResourceFile file) {
    if (file is PdfFile) {
      // todo: pdf
    } else if (file is WordFile) {
      // todo: word
    } else if (file is PPTFile) {
      // todo: ppt
    } else {
      throw UnsupportedError('暂时不支持这类文件解析');
    }
  }
}

/// 压缩类
class Compressor implements Visitor {
  @override
  void visit(ResourceFile file) {
    if (file is PdfFile) {
      // todo: pdf
    } else if (file is WordFile) {
      // todo: word
    } else if (file is PPTFile) {
      // todo: ppt
    } else {
      throw UnsupportedError('暂时不支持这类文件解析');
    }
  }
}

void _main() {
  Extractor extractor = Extractor();
  List<ResourceFile> resourceFiles = [];
  resourceFiles.add(PdfFile('a.pdf'));
  resourceFiles.add(WordFile('b.word'));
  resourceFiles.add(PPTFile('c.ppt'));

  for (ResourceFile file in resourceFiles) {
    file.accept(extractor);
  }

  Compressor compressor = Compressor();
  for (ResourceFile file in resourceFiles) {
    file.accept(compressor);
  }
}

/*
* 一般来说，访问者模式针对的是一组类型不同的对象（PdfFile、PPTFile、WordFile）。
* 不过，尽管这组对象的类型是不同的，但是，它们继承相同的父类（ResourceFile）或者实现相同的接口。
* 在不同的应用场景下，我们需要对这组对象进行一系列不相关的业务操作（抽取文本、压缩等），
* 但为了避免不断添加功能导致类（PdfFile、PPTFile、WordFile）不断膨胀，职责越来越不单一，
* 以及避免频繁地添加功能导致的频繁代码修改，我们使用访问者模式，将对象与操作解耦，
* 将这些业务操作抽离出来，定义在独立细分的访问者类（Extractor、Compressor）中。
* */
