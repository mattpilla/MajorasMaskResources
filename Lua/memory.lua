--[[
All of these functions should be self explanitory. They read and write
mainmemory using either the physical address or virtual address in
kernal segment 0 or 1 (since the low 3 bytes are the same for all 3).

That is to say, if the physical address is 0x00123456, then you can pass
0x00123456 (physical address), 0x80123456 (kernal segment 0),
or 0xA0123456 (kernal segment 1)
--]]


function readByte(addr)
	return mainmemory.readbyte(bit.band(addr,0x00FFFFFF))
end

function writeByte(addr,val)
	return mainmemory.writebyte(bit.band(addr,0x00FFFFFF),val)
end

--===================================================================

function readShort(addr)
	return mainmemory.read_s16_be(bit.band(addr,0x00FFFFFF))
end

function readS16(addr)
	return readShort(addr)
end

function writeShort(addr,val)
	return mainmemory.write_s16_be(bit.band(addr,0x00FFFFFF),val)
end

function writeS16(addr,val)
	return writeShort(addr)
end
---------
function readHWord(addr)
	return mainmemory.read_u16_be(bit.band(addr,0x00FFFFFF))
end

function readU16(addr)
	return readHWord(addr)
end

function writeHWord(addr)
	return mainmemory.write_u16_be(bit.band(addr,0x00FFFFFF), val)
end

function writeU16(addr,val)
	return writeHWord(addr,val)
end

--===================================================================

function readS24(addr)
	return mainmemory.read_s24_be(bit.band(addr,0x00FFFFFF))
end

function writeS24(addr,val)
	return mainmemory.write_s24_be(bit.band(addr,0x00FFFFFF), val)
end
---------
function readU24(addr)
	return mainmemory.read_u24_be(bit.band(addr,0x00FFFFFF))
end

function writeU24(addr,val)
	return mainmemory.write_u24_be(bit.band(addr,0x00FFFFFF), val)
end

--===================================================================

function readLong(addr)
	return mainmemory.read_s32_be(bit.band(addr,0x00FFFFFF))
end

function readS32(addr)
	return readLong(addr)
end

function writeLong(addr, val)
	return mainmemory.write_s32_be(bit.band(addr,0x00FFFFFF), val)
end

function writeS32(addr, val)
	return writeLong(addr, val)
end

---------

function readWord(addr)
	return mainmemory.read_u32_be(bit.band(addr,0x00FFFFFF))
end

function readU32(addr)
	return readWord(addr)
end

function writeWord(addr, val)
	return mainmemory.write_u32_be(bit.band(addr,0x00FFFFFF), val)
end

function writeU32(addr, val)
	return writeWord(addr, val)
end

--===================================================================
--Converts a segmented address (seg) to an addressable useable by the
--above function by providing a base. Would like to eventually expand
--it to be able to just take in the segmented address and have it
--look up the base
function segToAddr(base, seg)
	return base + readU24(seg + 1)
end
