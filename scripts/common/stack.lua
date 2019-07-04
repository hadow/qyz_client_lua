-- local Stack = require "common.statck"
local linkedlist         = require "common.linkedlist"
local LinkedListNode     = linkedlist.LinkedListNode
local LinkedListIterator = linkedlist.LinkedListIterator
local LinkedList         = linkedlist.LinkedList

local Stack = Class:new(LinkedList)
 
function Stack:Top()
    if not self:IsEmpty() then
        return self:First().value
    end
    return nil
end
 
function Stack:Push(a)
    self:AddFirst(a)
end
 
function Stack:Pop()
    if not self:IsEmpty() then
        return self:RemoveFirst().value
    end
    return nil
end
return Stack
 