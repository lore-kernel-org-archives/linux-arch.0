From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 00/15] Provide atomics and bitops implemented with ISO
 C++11 atomics
Date: Wed, 18 May 2016 16:10:37 +0100
Message-ID: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbcERPKk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 May 2016 11:10:40 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org


Here's a set of patches to provide kernel atomics and bitops implemented
with ISO C++11 atomic intrinsics.  The second part of the set makes the x86
arch use the implementation.

Note that the x86 patches are very rough.  It would need to be made
compile-time conditional in some way and the old code can't really be
thrown away that easily - but it's a good way to make sure I'm not using
that code any more.


There are some advantages to using ISO C++11 atomics:

 (1) The compiler can make use of extra information, such as condition
     flags, that are tricky to get out of inline assembly in an efficient
     manner.  This should reduce the number of instructions required in
     some cases - such as in x86 where we use SETcc to store the condition
     inside the inline asm and then CMP outside to put it back again.

     Whilst this can be alleviated by the use of asm-goto constructs, this
     adds mandatory conditional jumps where the use of CMOVcc and SETcc
     might be better.

 (2) The compiler inserts memory barriers for us and can move them earlier,
     within reason, thereby affording a greater chance of the CPU being
     able to execute the memory barrier instruction simultaneously with
     register-only instructions.

 (3) The compiler can automatically switch between different forms of an
     atomic instruction depending on operand size, thereby eliminating the
     need for large switch statements with individual blocks of inline asm.

 (4) The compiler can automatically switch between different available
     atomic instructions depending on the values in the operands (INC vs
     ADD) and whether the return value is examined (ADD vs XADD) and how it
     is examined (ADD+Jcc vs XADD+CMP+Jcc).


There are some disadvantages also:

 (1) It's not available in gcc before gcc-4.7 and there will be some
     seriously suboptimal code production before gcc-7.1.

 (2) The compiler might misoptimise - for example, it might generate a
     CMPXCHG loop rather than a BTR instruction to clear a bit.

 (3) The C++11 memory model permits atomic instructions to be merged if
     appropriate - for example, two adjacent __atomic_read() calls might
     get merged if the return value of the first isn't examined.  Making
     the pointers volatile alleviates this.  Note that gcc doesn't do this
     yet.

 (4) The C++11 memory barriers are, in general, weaker than the kernel's
     memory barriers are defined to be.  Whether this actually matters is
     arch dependent.  Further, the C++11 memory barriers are
     acquire/release, but some arches actually have load/store instead -
     which may be a problem.

 (5) On x86, the compiler doesn't tell you where the LOCK prefixes are so
     they cannot be suppressed if only one CPU is online.


Things to be considered:

 (1) We could weaken the kernel memory model to for the benefit of arches
     that have instructions that employ explicit acquire/release barriers -
     but that may cause data races to occur based on assumptions we've
     already made.  Note, however, that powerpc already seems to have a
     weaker memory model.

 (2) There are three sets of atomics (atomic_t, atomic64_t and
     atomic_long_t).  I can either put each in a separate file all nicely
     laid out (see patch 3) or I can make a template header (see patch 4)
     and use #defines with it to make all three atomics from one piece of
     code.  Which is best?  The first is definitely easier to read, but the
     second might be easier to maintain.

 (3) I've added cmpxchg_return() and try_cmpxchg() to replace cmpxchg().
     I've also provided atomicX_t variants of these.  These return the
     boolean return value from the __atomic_compare_exchange_n() function
     (which is carried in the Z flag on x86).  Should this be rolled out
     even without the ISO atomic implementation?

 (4) The current x86_64 bitops (set_bit() and co.) are technically broken.
     The set_bit() function, for example, takes a 64-bit signed bit number
     but implements this with BTSL, presumably because it's a shorter
     instruction.

     The BTS instruction's bit number operand, however, is sized according
     to the memory operand, so the upper 32 bits of the bit number are
     discarded by BTSL.  We should really be using BTSQ to implement this
     correctly (and gcc does just that).  In practice, though, it would
     seem unlikely that this will ever be a problem as I think we're
     unlikely to have a bitset with more than ~2 billion bits in it within
     the kernel (it would be >256MiB in size).

     Patch 9 casts the pointers internally in the bitops functions to
     persuade the kernel to use 32-bit bitops - but this only really
     matters on x86.  Should set_bit() and co. take int rather than long
     bit number arguments to make the point?


I've opened a number of gcc bugzillas to improve the code generated by the
atomics:

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49244

     __atomic_fetch_{and,or,xor}() don't generate locked BTR/BTS/BTC on x86
     and __atomic_load() doesn't generate TEST or BT.  There is a patch for
     this, but it leaves some cases not fully optimised.

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70821

     __atomic_fetch_{add,sub}() generates XADD rather than DECL when
     subtracting 1 on x86.  There is a patch for this.

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70825

     __atomic_compare_exchange_n() accesses the stack unnecessarily,
     leading to extraneous stores being added when everything could be done
     entirely within registers (on x86, powerpc64, aarch64).

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70973

     Can the __atomic*() ops on x86 generate a list of LOCK prefixes?

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71153

     aarch64 __atomic_fetch_and() generates a double inversion for the
     LDSET instructions.  There is a patch for this.

 (*) https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71162

     powerpc64 should probably emit BNE- not BNE to retry the STDCX.


The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=iso-atomic

I have fixed up an x86_64 cross-compiler with the patches that I've been
given for the above and have booted the resulting kernel.

David
---
David Howells (15):
      cmpxchg_local() is not signed-value safe, so fix generic atomics
      tty: ldsem_cmpxchg() should use cmpxchg() not atomic_long_cmpxchg()
      Provide atomic_t functions implemented with ISO-C++11 atomics
      Convert 32-bit ISO atomics into a template
      Provide atomic64_t and atomic_long_t using ISO atomics
      Provide 16-bit ISO atomics
      Provide cmpxchg(), xchg(), xadd() and __add() based on ISO C++11 intrinsics
      Provide an implementation of bitops using C++11 atomics
      Make the ISO bitops use 32-bit values internally
      x86: Use ISO atomics
      x86: Use ISO bitops
      x86: Use ISO xchg(), cmpxchg() and friends
      x86: Improve spinlocks using ISO C++11 intrinsic atomics
      x86: Make the mutex implementation use ISO atomic ops
      x86: Fix misc cmpxchg() and atomic_cmpxchg() calls to use try/return variants


 arch/x86/events/amd/core.c                |    6 
 arch/x86/events/amd/uncore.c              |    4 
 arch/x86/include/asm/atomic.h             |  224 -----------
 arch/x86/include/asm/bitops.h             |  143 -------
 arch/x86/include/asm/cmpxchg.h            |   99 -----
 arch/x86/include/asm/cmpxchg_32.h         |    3 
 arch/x86/include/asm/cmpxchg_64.h         |    6 
 arch/x86/include/asm/mutex.h              |    6 
 arch/x86/include/asm/mutex_iso.h          |   73 ++++
 arch/x86/include/asm/qspinlock.h          |    2 
 arch/x86/include/asm/spinlock.h           |   18 +
 arch/x86/kernel/acpi/boot.c               |   12 -
 arch/x86/kernel/apic/apic.c               |    3 
 arch/x86/kernel/cpu/mcheck/mce.c          |    7 
 arch/x86/kernel/kvm.c                     |    5 
 arch/x86/kernel/smp.c                     |    2 
 arch/x86/kvm/mmu.c                        |    2 
 arch/x86/kvm/paging_tmpl.h                |   11 -
 arch/x86/kvm/vmx.c                        |   21 +
 arch/x86/kvm/x86.c                        |   19 -
 arch/x86/mm/pat.c                         |    2 
 arch/x86/xen/p2m.c                        |    3 
 arch/x86/xen/spinlock.c                   |    6 
 drivers/tty/tty_ldsem.c                   |    2 
 include/asm-generic/atomic.h              |   17 +
 include/asm-generic/iso-atomic-long.h     |   32 ++
 include/asm-generic/iso-atomic-template.h |  572 +++++++++++++++++++++++++++++
 include/asm-generic/iso-atomic.h          |   28 +
 include/asm-generic/iso-atomic16.h        |   27 +
 include/asm-generic/iso-atomic64.h        |   28 +
 include/asm-generic/iso-bitops.h          |  188 ++++++++++
 include/asm-generic/iso-cmpxchg.h         |  180 +++++++++
 include/linux/atomic.h                    |   26 +
 33 files changed, 1225 insertions(+), 552 deletions(-)
 create mode 100644 arch/x86/include/asm/mutex_iso.h
 create mode 100644 include/asm-generic/iso-atomic-long.h
 create mode 100644 include/asm-generic/iso-atomic-template.h
 create mode 100644 include/asm-generic/iso-atomic.h
 create mode 100644 include/asm-generic/iso-atomic16.h
 create mode 100644 include/asm-generic/iso-atomic64.h
 create mode 100644 include/asm-generic/iso-bitops.h
 create mode 100644 include/asm-generic/iso-cmpxchg.h
