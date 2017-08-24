From: Hoeun Ryu <hoeun.ryu@gmail.com>
Subject: [RFC 0/3] add 64BIT_ATOMIC_ACCESS and 64BIT_ATOMIC_ALIGNED_ACCESS
Date: Thu, 24 Aug 2017 14:42:54 +0900
Message-ID: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35687 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdHXFr1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2017 01:47:27 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@kernel.org>, Michal Marek <mmarek@suse.com>, Laura Abbott <labbott@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, mic@digikod.net, Russell King <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jonathan Austin <jonathan.austin@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hoeun.ryu@gmail.com, linux-arch@vger.kernel.org

 On some 32-bit architectures, 64bit accesses are atomic when certain
conditions are satisfied.

 For example, on LPAE (Large Physical Address Extension) enabled ARM
architecture, 'ldrd/strd' (load/store doublewords) instructions are 64bit
atomic as long as the address is 64-bit aligned. This feature is to
guarantee atomic accesses on newly introduced 64bit wide descriptors in
the translation tables, and 's/u64' variables can be accessed atomically
when they are aligned(8) on LPAE enabled ARM architecture machines.

 Introducing 64BIT_ATOMIC_ACCESS and 64BIT_ATOMIC_ALIGNED_ACCESS, which
can be true for the 32bit architectures as well as 64bit architectures.

 we can optimize some kernel codes using seqlock (timekeeping) or mimics
of it (like in sched/cfq) simply to read or write 64bit variables.
 The existing codes depend on CONFIG_64BIT to determine whether the 64bit
variables can be directly accessed or need additional synchronization
primitives like seqlock. CONFIG_64BIT_ATOMIC_ACCESS can be used instead of
CONFIG_64BIT in the cases.

 64BIT_ATOMIC_ALIGNED_ACCESS can be used in the variable declaration to
indicate the alignment requirement to the compiler
(__attribute__((aligned(8)))) in the way of #ifdef.

 The last patch "sched: depend on 64BIT_ATOMIC_ACCESS to determine if to
use min_vruntime_copy" is an example of this approach.

 I'd like to know what the architecture maintainers and kernel maintainers
think about it. I think I can make more examples (mostly removing seqlock
to access the 64bit variables on the machines) if this approach is
accepted.

Hoeun Ryu (3):
  arch: add 64BIT_ATOMIC_ACCESS to support 64bit atomic access on 32bit
    machines
  arm: enable 64BIT_ATOMIC(_ALIGNED)_ACCESS on LPAE enabled machines
  sched: depend on 64BIT_ATOMIC_ACCESS to determine if to use
    min_vruntime_copy

 arch/Kconfig         | 20 ++++++++++++++++++++
 arch/arm/mm/Kconfig  |  2 ++
 kernel/sched/fair.c  |  6 +++---
 kernel/sched/sched.h |  6 +++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.7.4
