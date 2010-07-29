/*
  Copyright (C) 2000-2005 SKYRIX Software AG

  This file is part of SOPE.

  SOPE is free software; you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the
  Free Software Foundation; either version 2, or (at your option) any
  later version.

  SOPE is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
  License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with SOPE; see the file COPYING.  If not, write to the
  Free Software Foundation, 59 Temple Place - Suite 330, Boston, MA
  02111-1307, USA.
*/

#include "DOMNode+Enum.h"
#include "common.h"

@interface _DOMNodeParentNodeEnumerator : NSEnumerator
{
  id currentNode;
}
+ (id)enumeratorWithDOMNode:(id)_node;
@end

@implementation NSObject(DOMNodeEnum)

- (NSEnumerator *)domParentNodeEnumerator {
  return [_DOMNodeParentNodeEnumerator enumeratorWithDOMNode:
                                         [(NGDOMNode *)self parentNode]];
}

@end /* NSObject(DOMNodeEnum) */

@implementation NGDOMNode(Enum)

- (NSEnumerator *)parentNodeEnumerator {
  return [self domParentNodeEnumerator];
}

@end /* NGDOMNode(Enum) */

@implementation _DOMNodeParentNodeEnumerator

+ (id)enumeratorWithDOMNode:(id)_node {
  _DOMNodeParentNodeEnumerator *e;
  e = [self alloc];
  e->currentNode = [_node retain];
  return [e autorelease];
}

- (void)dealloc {
  [self->currentNode release];
  [super dealloc];
}

- (id)nextObject {
  id old;

  old = self->currentNode;
  self->currentNode = [[old parentNode] retain];
  return [old autorelease];
}

@end /* _DOMNodeParentNodeEnumerator */
