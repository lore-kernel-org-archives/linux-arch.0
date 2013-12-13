From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] arch: Introduce smp_load_acquire() and smp_store_release()
Date: Fri, 13 Dec 2013 15:56:57 +0100
Message-ID: <20131213145657.265414969@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45054 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab3LMPJQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2013 10:09:16 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org
Cc: geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Peter Zijlstra <peterz@infradead.org>

These patches introduce 2 new barrier primitives:

  smp_load_acquire(p)
  smp_store_release(p, v)

See the first patch, which changes Documentation/memory-barriers.txt, to find
the exact definitions of what an ACQUIRE/RELEASE barrier is -- previously known
as LOCK/UNLOCK barriers.

The second patch moves the smp_mb__{before,after}_atomic_{dec,inc}() barriers
to asm/atomic.h for arc and hexagon -- they were already there for all other archs.

This cleans up asm/barrier.h, and the third patch makes more agressive use of
asm-generic/barrier.h to implement the simple cases.

Then the fourth patch adds the new primitives.

Previous versions were widely build tested -- this version is not, but it also
not significantly different.

These patches apply to:

  tip/master + lkml.kernel.org/r/20131211215850.GA810@linux.vnet.ibm.com


---
Changes since the last version -- lkml.kernel.org/r/20131107220314.740353088@infradead.org

 - rebased
 - broke out the smp_mb__*atomic* movement
 - changed the ia64 implementation to use volatile instead
   of actual ASM goo -- Tony, do let me know if you would
   prefer to have the ASM goo back; but given you said that
   gcc-ia64 generates the right instructions for volatile...
