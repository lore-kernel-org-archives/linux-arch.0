From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 00/28] arch: Provide atomic logic ops
Date: Thu, 16 Jul 2015 19:21:10 +0200
Message-ID: <20150716172110.587529075@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Currently there is an incoherent mess of atomic_{set,clear}_mask() and
atomic_or() (but no atomic_{and,nand,xor}()) in the tree.

Those archs that implement atomic_{set,clear}_mask() are not even consistent on
its signature.

Implement atomic_{or,and,xor}() on all archs and deprecate
atomic_{set,clear}_mask().

The series has been compile tested by the build-bot, no known failures at this time.

I would like to take this through tip; I'll ask Ingo to put it in a separate
branch such that people can pull in that branch if there is conflicting work
elsewhere (Will has some for Argh64).


Changes since lst time:

 - Quite a few build fails fixed, most notable would be that each arch
   now defines CONFIG_ARCH_HAS_ATOMIC_OR for a little while -- we take it
   out again later.

 - FRV has some extra magic that allows the inline assembly to correctly
   work as inline functions.

 - TILE patch contributed by Chris -- Thanks!

 - A little extention to lib/atomic64_test.c that compile tests the new
   primitives.

 - Alpha, fixed ASM due to fallout from actually trying to compile things.

 - H8300, somehow I had overlooked it previously.

 - Added atomic_andnot() to a few archs that have that instruction to test that.
