{{
 SD2.0 FATEngine Wrapper
 by Roy Eltham
 11/18/2010
 Copyright (c) 2010 Roy Eltham
 See end of file for terms of use.
 
 Log:
 Mike G - added a few methods, for got which though...
}}

CON
  _clkfreq = 80_000_000
  _clkmode = xtal1 + pll16x

  _cardDataOutPin     = 16
  _cardClockPin       = 21
  _cardDataInPin      = 20
  _cardChipSelectPin  = 19
  I2C_CLOCK           = 28 
  I2C_DATA            = 29
  DEFAULT_PARTITION   = 0 

DAT
  ok  byte  "OK", $0
  t1  long  $00 

OBJ
   fat: "S35390A_SD-MMC_FATEngine.spin"  
 
PUB Start
  return fat.FATEngineStart(_cardDataOutPin, _cardClockPin, _cardDataInPin, _cardChipSelectPin, -1, -1, I2C_DATA, I2C_CLOCK, -1)

PUB GetCogID
  return fat.GetCogID
  
'PUB fileTime
  'return fat.fileTime

PUB mount(partition)
                                               
  if(partition == -1)
    t1 := DEFAULT_PARTITION
  else
    t1 := partition
      
  t1 := \fat.mountPartition(t1)
  
  if(fat.IsAbort(t1))
    return t1
  else
    return @ok

PUB openFile(fileName, action)
  t1 := \fat.openFile(fileName, action)
  if(fat.IsAbort(t1))
    return t1
  return true

PUB listEntry(entryPathName)
 t1 := \fat.listEntry(entryPathName)
 if(fat.IsAbort(t1))
    return t1
  return true

  
PUB LastError
  return fat.LastAbort  
 
PUB unmount(stringPointer)
  return fat.unmountPartition

PUB changeDirectory(directoryName)
  return fat.changeDirectory(directoryName)





PUB listEntries(cmd) | temp, index
  return fat.listEntries(cmd)


PUB startFindFile
  fat.listEntries("W")
    
PUB nextFile | temp, index
  temp := fat.listEntries("N")
  repeat index from 0 to 11
    if byte[temp][index] == 32
       byte[temp][index] := 0
       quit
  return temp


PUB closeFile
  return fat.closeFile

PUB getFileSize
  return fat.listSize
  
PUB readFromFile(bufferPtr, bufferSize)
  return fat.readData(bufferPtr, bufferSize)

PUB deleteEntry(name)
  return fat.deleteEntry(name)
  
PUB newFile(fileName)
  return fat.newFile(fileName)

PUB writeData(addressToGet, count)
  return fat.writeData(addressToGet, count)

  
PUB readByte
  return fat.readByte

PUB fileSeek(position)
  return fat.fileSeek(position) 
  

     
{{
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                 │                                                            
├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation   │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,   │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the        │
│Software is furnished to do so, subject to the following conditions:                                                         │         
│                                                                                                                             │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the         │
│Software.                                                                                                                    │
│                                                                                                                             │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE         │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR        │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,  │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                        │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}                        