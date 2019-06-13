From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCHv2 0/3] improve wait logic of stop_machine
Date: Thu, 13 Jun 2019 12:35:07 +0200
Message-ID: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

FWIW, it would be nice to get some Acks.

Given that this patch set touches common code only in a way that
shouldn't have any effect on any architecture except s390, I'll add
this to the s390 tree, unless somebody objects.

RFC->v2:
  Use cpumask_next_wrap as suggested by Peter Zijlstra.

RFC:

The stop_machine loop to advance the state machine and to wait for all
affected CPUs to check-in calls cpu_relax_yield in a tight loop until
the last missing CPUs acknowledged the state transition.

On a virtual system where not all logical CPUs are backed by real CPUs
all the time it can take a while for all CPUs to check-in. With the
current definition of cpu_relax_yield on s390 a diagnose 0x44 is done
which tells the hypervisor to schedule *some* other CPU. That can be
any CPU and not necessarily one of the CPUs that need to run in order
to advance the state machine. This can lead to a pretty bad diagnose
0x44 storm until the last missing CPU finally checked-in.

Replace the undirected cpu_relax_yield based on diagnose 0x44 with an
architecture specific directed yield. Each CPU in the wait loop will
pick up the next CPU in the cpumask of stop_machine. The diagnose 0x9c
is used to tell the hypervisor to run this next CPU instead of the
current one. If there is only a limited number of real CPUs backing
the virtual CPUs we end up with the real CPUs passed around in a
round-robin fashion.

Patches 1 and 3 are just possible cleanups; the interesting part is
patch 2.

Heiko Carstens (2):
  processor: remove spin_cpu_yield
  processor: get rid of cpu_relax_yield

Martin Schwidefsky (1):
  s390: improve wait logic of stop_machine

 arch/powerpc/include/asm/processor.h |  2 --
 arch/s390/include/asm/processor.h    |  7 +------
 arch/s390/kernel/processor.c         | 19 +++++++++++++------
 arch/s390/kernel/smp.c               |  2 +-
 include/linux/processor.h            |  9 ---------
 include/linux/sched.h                |  4 ----
 include/linux/stop_machine.h         |  1 +
 kernel/stop_machine.c                | 19 ++++++++++++++-----
 8 files changed, 30 insertions(+), 33 deletions(-)

-- 
2.17.1
