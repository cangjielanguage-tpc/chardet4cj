# 三方库设计说明

## 1 需求场景分析

    juniversalchardet 是一个字符编码高效识别检测库
    参考项目：https://github.com/albfernandez/juniversalchardet

## 2 三方库对外提供的特性
    
    （1）支持 ISO-2022-CN

    （2）支持 UTF-8
    	
    （3）支持 UTF-16BE / UTF-16LE

## 3 License分析

     MOZILLA PUBLIC LICENSE
    	Version 1.1
    
    |  Permissions   | Limitations  |
    |  ----  | ----  |
    | Commercial use |  Trademark use  |
    | Modification  |  Liability  |
    | Distribution  |  Warranty  |
    | Patent use  |   |
    | Private use   |   |

## 4 依赖分析

    Charset.defaultCharset()
    class InputStream 
    	reset()
    	skip(n)

## 5 特性设计文档

### 5.1 字符编码识别

#### 5.1.1 特性介绍

    提供字符编码识别功能

#### 5.1.2 实现方案

#####  UniversalDetector
```cangjie
文本编码检测
public class UniversalDetector {
    /*
     * 初始化 UniversalDetector
     *
     * 
     */
    public init()
    
    /*
     * 初始化 UniversalDetector
     *
     * 参数 listener - 通知的侦听器对象
     * 
     */
    public init(listener: CharsetListener) 
    
    /*
     * 判断是否完成
     *
     * 返回值 Bool - 完成后的状态
     */
    public func isDone(): Bool 
    
    /*
     * 检测到的编码
     *
     * 返回值 String - 返回检测到的编码
     */
    public func getDetectedCharset(): String 
    
    /*
     * 设置监听对象
     *
     * 参数 listener - 通知的侦听器对象
     * 
     */
    public func setListener(listener: CharsetListener)
    
    /*
     * 获取设置监听对象
     *
     * 返回值 CharsetListener - 通知的侦听器对象
     * 
     */
    public func setListener(): CharsetListener
    
    /*
     * 处理检测的数据
     *
     * 参数 buf - 检测的数据
     * 
     */
    public func handleData(buf: Array<Byte>)
    
    /*
     * 处理检测的数据
     *
     * 参数 buf - 检测的数据
     * 参数 offset - 数据起始位置
     * 参数 length - 检测的数据长度
     */
    public func handleData(buf: Array<Byte>, offset: Int64, length : Int64)
    
    /*
     * 处理检测的数据
     *
     * 参数 buf - 检测的数据
     * 返回值 String - 字符编码的类型
     */
    public func detectCharsetFromBOM(buf: Array<Byte>): String
    
    
    /*
     * 处理检测的数据
     *
     * 参数 buf - 检测的数据
     * 参数 offset - 数据起始位置
     * 返回值 String - 字符编码的类型
     */
    public func detectCharsetFromBOM(buf: Array<Byte>,offset: Int64): String
    
    /*
     * 标记数据读取的结束
     *
     */
    public func dataEnd()
    
    /*
     * 标记数据重置
     *
     */
    public func reset()
    
    /*
     * 获取文件的字符集
     *
     * 参数 file - 检测的文件
     * 返回值 String - 字符编码的类型
     */
    public func detectCharset(file: File): String
    
    /*
     * 获取Path的字符集
     *
     * 参数 path - 检测的文件路径
     * 返回值 String - 字符编码的类型
     */
    public func detectCharset(path: Path): String 
    
    /*
     * 处理检测的数据流
     *
     * 参数 inputStream - 检测的数据流
     * 返回值 String - 字符编码的类型
     */
    public func detectCharset(inputStream: InputStream): String
}
```

#####  EncodingDetectorInputStream
```cangjie
读取时检测编码的流。
public class EncodingDetectorInputStream <: InputStream{
    public init(in: InputStream) 
    public func available(): Int32
    public func close()
    public func mark(readlimit: Int32)
    public func markSupported(): Bool
    public func read(): Int32
    public func read(b: Array<byte>, off: Int32, len: Int32): Int32
    public func read(b: Array<byte>): Int64
    public func reset()
    public func skip(n: Int64): Int64
    public func getDetectedCharset(): String
}
```

#####  EncodingDetectorOutputStream
```cangjie
读取时检测编码的流
public class EncodingDetectorOutputStream <: OutputStream{
    public init(in: OutputStream) 
    public func close()
    public func flush()
    public func write(b: Array<byte>, off: Int32, len: Int32)
    public func write(b: Array<byte>)
    public func write(b: Int32)
    public func getDetectedCharset(): String
}
```

#####  UnicodeBOMInputStream
```cangjie
描述不同类型Unicode的类型安全枚举类
public class UnicodeBOMInputStream <: InputStream{
    public init(in: InputStream) 
    public init(in: InputStream,skipIfFound: Bool ) 
    public func getBOM(): BOM
    public func skipBOM(): UnicodeBOMInputStream
    public func read(): Int32
    public func read(b: Array<byte>, off: Int32, len: Int32): Int32
    public func read(b: Array<byte>): Int32
    public func skip(n: Int64): Int64
    public func available(): Int32
    public func close()
    public func reset()
    public func mark(readlimit: Int32)
    public func markSupported(): Bool
}
```