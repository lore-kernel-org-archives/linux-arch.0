From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST 0/5] Simplify setting thread flags to a particular value
Date: Fri, 11 May 2018 16:04:59 +0100
Message-ID: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

There are a number of bits of code sprinkled around the kernel to
set a thread flag if a certain condition is true, and clear it
otherwise.

This series ports relevant bits of code to use the new
update_thread_flag() helpers implemented in [2].


Note: This is a repost of a previous RFC [1].  Part of patch 1, and
all of patch 4 of that series have been split out and reviewed
separately ([2], [3] respectively).  I currently expect them to merge
via Marc's KVM tree.

The remainder of the patches from [1] are reposted here.

Patch 1 ports some core code that to use the update_thread_flag()
helpers.

The remaining patches port relevant bits of arch code.

Build-tested on the affected architectures; some context switch stress
testing done on arm64, which exercises a few call sites for the new
helpers.

Comments welcome.

Cheers
---Dave


[1] [RFC PATCH 0/6] Simplify setting thread flags to a particular value
https://lkml.org/lkml/2018/4/19/225

[2] [PATCH v7 01/16] thread_info: Add update_thread_flag() helpers
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576596.html

[3] [PATCH v7 02/16] arm64: Use update{,_tsk}_thread_flag()
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576597.html

Dave Martin (5):
  thread_info: Port core code to use update_thread_flag() helpers
  ARM: Use update_thread_flag()
  MIPS: Use update{,_tsk}_thread_flag()
  powerpc: Use update_thread_flag()
  sparc: Use update_thread_flag()

 arch/arm/kernel/elf.c           |  9 +++------
 arch/mips/kernel/elf.c          | 10 ++--------
 arch/mips/kernel/process.c      | 15 ++++++---------
 arch/mips/kernel/ptrace.c       |  5 +----
 arch/mips/kernel/syscall.c      | 10 ++--------
 arch/powerpc/include/asm/elf.h  | 10 ++--------
 arch/sparc/include/asm/elf_64.h |  5 +----
 include/trace/syscall.h         |  6 ++----
 kernel/ptrace.c                 | 13 +++++--------
 9 files changed, 24 insertions(+), 59 deletions(-)

-- 
2.1.4
