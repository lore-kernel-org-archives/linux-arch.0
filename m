From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v3 0/9] Remove spin_unlock_wait()
Date: Fri, 7 Jul 2017 12:27:04 -0700
Message-ID: <20170707192704.GA6144@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <20170705232955.GA15992@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49861 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751034AbdGGT1L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 15:27:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67JONWe023502
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 15:27:11 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjf19twsp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 15:27:11 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 15:27:10 -0400
Content-Disposition: inline
In-Reply-To: <20170705232955.GA15992@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org

Hello!

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This series therefore removes spin_unlock_wait() and changes
its users to instead use a lock/unlock pair.  The commits are as follows,
in three groups:

1-7.	Change uses of spin_unlock_wait() and raw_spin_unlock_wait()
	to instead use a spin_lock/spin_unlock pair.  These may be
	applied in any order, but must be applied before any later
	commits in this series.  The commit logs state why I believe
	that these commits won't noticeably degrade performance.

8.	Remove core-kernel definitions for spin_unlock_wait() and
	raw_spin_unlock_wait().

9.	Remove arch-specific definitions of arch_spin_unlock_wait().

Changes since v2:

o	Add comment-only update from Manfred.

Changes since v1:

o	Disable interrupts where needed, thus avoiding embarrassing
	interrupt-based self-deadlocks.

o	Substitute Manfred's patch for contrack_lock (#1 above).

o	Substitute Oleg's patch for task_work (#2 above).

o	Use more efficient barrier based on Arnd Bergmann feedback.

o	Merge the arch commits.

							Thanx, Paul

------------------------------------------------------------------------

 arch/alpha/include/asm/spinlock.h    |    5 -
 arch/arc/include/asm/spinlock.h      |    5 -
 arch/arm/include/asm/spinlock.h      |   16 ----
 arch/arm64/include/asm/spinlock.h    |   58 +----------------
 arch/blackfin/include/asm/spinlock.h |    5 -
 arch/hexagon/include/asm/spinlock.h  |    5 -
 arch/ia64/include/asm/spinlock.h     |   21 ------
 arch/m32r/include/asm/spinlock.h     |    5 -
 arch/metag/include/asm/spinlock.h    |    5 -
 arch/mips/include/asm/spinlock.h     |   16 ----
 arch/mn10300/include/asm/spinlock.h  |    5 -
 arch/parisc/include/asm/spinlock.h   |    7 --
 arch/powerpc/include/asm/spinlock.h  |   33 ---------
 arch/s390/include/asm/spinlock.h     |    7 --
 arch/sh/include/asm/spinlock-cas.h   |    5 -
 arch/sh/include/asm/spinlock-llsc.h  |    5 -
 arch/sparc/include/asm/spinlock_32.h |    5 -
 arch/sparc/include/asm/spinlock_64.h |    5 -
 arch/tile/include/asm/spinlock_32.h  |    2 
 arch/tile/include/asm/spinlock_64.h  |    2 
 arch/tile/lib/spinlock_32.c          |   23 ------
 arch/tile/lib/spinlock_64.c          |   22 ------
 arch/xtensa/include/asm/spinlock.h   |    5 -
 drivers/ata/libata-eh.c              |    8 --
 include/asm-generic/qspinlock.h      |   14 ----
 include/linux/spinlock.h             |   31 ---------
 include/linux/spinlock_up.h          |    6 -
 ipc/sem.c                            |    3 
 kernel/exit.c                        |    3 
 kernel/locking/qspinlock.c           |  117 -----------------------------------
 kernel/sched/completion.c            |    9 --
 kernel/sched/core.c                  |    5 -
 kernel/task_work.c                   |    8 --
 net/netfilter/nf_conntrack_core.c    |   52 ++++++++-------
 34 files changed, 48 insertions(+), 475 deletions(-)
