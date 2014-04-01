From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v8 00/10] qspinlock: a 4-byte queue spinlock with PV support
Date: Tue,  1 Apr 2014 16:47:11 -0400
Message-ID: <1396385241-22736-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew
List-Id: linux-arch.vger.kernel.org

v7->v8:
  - Remove one unneeded atomic operation from the slowpath, thus
    improving performance.
  - Simplify some of the codes and add more comments.
  - Test for X86_FEATURE_HYPERVISOR CPU feature bit to enable/disable
    unfair lock.
  - Reduce unfair lock slowpath lock stealing frequency depending
    on its distance from the queue head.
  - Add performance data for IvyBridge-EX CPU.

v6->v7:
  - Remove an atomic operation from the 2-task contending code
  - Shorten the names of some macros
  - Make the queue waiter to attempt to steal lock when unfair lock is
    enabled.
  - Remove lock holder kick from the PV code and fix a race condition
  - Run the unfair lock & PV code on overcommitted KVM guests to collect
    performance data.

v5->v6:
 - Change the optimized 2-task contending code to make it fairer at the
   expense of a bit of performance.
 - Add a patch to support unfair queue spinlock for Xen.
 - Modify the PV qspinlock code to follow what was done in the PV
   ticketlock.
 - Add performance data for the unfair lock as well as the PV
   support code.

v4->v5:
 - Move the optimized 2-task contending code to the generic file to
   enable more architectures to use it without code duplication.
 - Address some of the style-related comments by PeterZ.
 - Allow the use of unfair queue spinlock in a real para-virtualized
   execution environment.
 - Add para-virtualization support to the qspinlock code by ensuring
   that the lock holder and queue head stay alive as much as possible.

v3->v4:
 - Remove debugging code and fix a configuration error
 - Simplify the qspinlock structure and streamline the code to make it
   perform a bit better
 - Add an x86 version of asm/qspinlock.h for holding x86 specific
   optimization.
 - Add an optimized x86 code path for 2 contending tasks to improve
   low contention performance.

v2->v3:
 - Simplify the code by using numerous mode only without an unfair option.
 - Use the latest smp_load_acquire()/smp_store_release() barriers.
 - Move the queue spinlock code to kernel/locking.
 - Make the use of queue spinlock the default for x86-64 without user
   configuration.
 - Additional performance tuning.

v1->v2:
 - Add some more comments to document what the code does.
 - Add a numerous CPU mode to support >= 16K CPUs
 - Add a configuration option to allow lock stealing which can further
   improve performance in many cases.
 - Enable wakeup of queue head CPU at unlock time for non-numerous
   CPU mode.

This patch set has 3 different sections:
 1) Patches 1-4: Introduces a queue-based spinlock implementation that
    can replace the default ticket spinlock without increasing the
    size of the spinlock data structure. As a result, critical kernel
    data structures that embed spinlock won't increase in size and
    break data alignments.
 2) Patches 5-6: Enables the use of unfair queue spinlock in a
    para-virtualized execution environment. This can resolve some
    of the locking related performance issues due to the fact that
    the next CPU to get the lock may have been scheduled out for a
    period of time.
 3) Patches 7-10: Enable qspinlock para-virtualization support
    by halting the waiting CPUs after spinning for a certain amount of
    time. The unlock code will detect the a sleeping waiter and wake it
    up. This is essentially the same logic as the PV ticketlock code.

The queue spinlock has slightly better performance than the ticket
spinlock in uncontended case. Its performance can be much better
with moderate to heavy contention.  This patch has the potential of
improving the performance of all the workloads that have moderate to
heavy spinlock contention.

The queue spinlock is especially suitable for NUMA machines with at
least 2 sockets, though noticeable performance benefit probably won't
show up in machines with less than 4 sockets.

The purpose of this patch set is not to solve any particular spinlock
contention problems. Those need to be solved by refactoring the code
to make more efficient use of the lock or finer granularity ones. The
main purpose is to make the lock contention problems more tolerable
until someone can spend the time and effort to fix them.

To illustrate the performance benefit of the queue spinlock, the
ebizzy benchmark was run with the -m option in two different computers:

  Test machine		ticket-lock		queue-lock
  ------------		-----------		----------
  4-socket 40-core	2316 rec/s		2899 rec/s
  Westmere-EX (HT off)
  2-socket 12-core	2130 rec/s		2176 rec/s
  Westmere-EP (HT on)

Waiman Long (10):
  qspinlock: A generic 4-byte queue spinlock implementation
  qspinlock, x86: Enable x86-64 to use queue spinlock
  qspinlock: More optimized code for smaller NR_CPUS
  qspinlock: Optimized code path for 2 contending tasks
  pvqspinlock, x86: Allow unfair spinlock in a PV guest
  pvqspinlock: Enable lock stealing in queue lock waiters
  pvqspinlock, x86: Rename paravirt_ticketlocks_enabled
  pvqspinlock, x86: Add qspinlock para-virtualization support
  pvqspinlock, x86: Enable qspinlock PV support for KVM
  pvqspinlock, x86: Enable qspinlock PV support for XEN

 arch/x86/Kconfig                      |   12 +
 arch/x86/include/asm/paravirt.h       |   17 +-
 arch/x86/include/asm/paravirt_types.h |   16 +
 arch/x86/include/asm/pvqspinlock.h    |  260 +++++++++
 arch/x86/include/asm/qspinlock.h      |  191 +++++++
 arch/x86/include/asm/spinlock.h       |    9 +-
 arch/x86/include/asm/spinlock_types.h |    4 +
 arch/x86/kernel/Makefile              |    1 +
 arch/x86/kernel/kvm.c                 |  113 ++++-
 arch/x86/kernel/paravirt-spinlocks.c  |   36 ++-
 arch/x86/xen/spinlock.c               |  121 ++++-
 include/asm-generic/qspinlock.h       |  126 ++++
 include/asm-generic/qspinlock_types.h |   63 ++
 kernel/Kconfig.locks                  |    7 +
 kernel/locking/Makefile               |    1 +
 kernel/locking/qspinlock.c            | 1010 +++++++++++++++++++++++++++++++++
 16 files changed, 1975 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/pvqspinlock.h
 create mode 100644 arch/x86/include/asm/qspinlock.h
 create mode 100644 include/asm-generic/qspinlock.h
 create mode 100644 include/asm-generic/qspinlock_types.h
 create mode 100644 kernel/locking/qspinlock.c
