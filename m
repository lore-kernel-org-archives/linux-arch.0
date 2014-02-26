From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 0/8] qspinlock: a 4-byte queue spinlock with PV support
Date: Wed, 26 Feb 2014 12:00:41 -0500
Message-ID: <20140226170041.GA20775@phenom.dumpdata.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Marcos Matsunaga <Marcos.Matsunaga@oracle.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 26, 2014 at 10:14:20AM -0500, Waiman Long wrote:
> v4->v5:
>  - Move the optimized 2-task contending code to the generic file to
>    enable more architectures to use it without code duplication.
>  - Address some of the style-related comments by PeterZ.
>  - Allow the use of unfair queue spinlock in a real para-virtualized
>    execution environment.
>  - Add para-virtualization support to the qspinlock code by ensuring
>    that the lock holder and queue head stay alive as much as possible.
> 
> v3->v4:
>  - Remove debugging code and fix a configuration error
>  - Simplify the qspinlock structure and streamline the code to make it
>    perform a bit better
>  - Add an x86 version of asm/qspinlock.h for holding x86 specific
>    optimization.
>  - Add an optimized x86 code path for 2 contending tasks to improve
>    low contention performance.
> 
> v2->v3:
>  - Simplify the code by using numerous mode only without an unfair option.
>  - Use the latest smp_load_acquire()/smp_store_release() barriers.
>  - Move the queue spinlock code to kernel/locking.
>  - Make the use of queue spinlock the default for x86-64 without user
>    configuration.
>  - Additional performance tuning.
> 
> v1->v2:
>  - Add some more comments to document what the code does.
>  - Add a numerous CPU mode to support >= 16K CPUs
>  - Add a configuration option to allow lock stealing which can further
>    improve performance in many cases.
>  - Enable wakeup of queue head CPU at unlock time for non-numerous
>    CPU mode.
> 
> This patch set has 3 different sections:
>  1) Patches 1-3: Introduces a queue-based spinlock implementation that
>     can replace the default ticket spinlock without increasing the
>     size of the spinlock data structure. As a result, critical kernel
>     data structures that embed spinlock won't increase in size and
>     breaking data alignments.
>  2) Patches 4 and 5: Enables the use of unfair queue spinlock in a
>     real para-virtualized execution environment. This can resolve
>     some of the locking related performance issues due to the fact
>     that the next CPU to get the lock may have been scheduled out
>     for a period of time.
>  3) Patches 6-8: Enable qspinlock para-virtualization support by making
>     sure that the lock holder and the queue head stay alive as long as
>     possible.
> 
> Patches 1-3 are fully tested and ready for production. Patches 4-8, on
> the other hands, are not fully tested. They have undergone compilation
> tests with various combinations of kernel config setting and boot-up
> tests in a non-virtualized setting. Further tests and performance
> characterization are still needed to be done in a KVM guest. So
> comments on them are welcomed. Suggestions or recommendations on how
> to add PV support in the Xen environment are also needed.

It should be fairly easy. You just need to implement the kick right?
An IPI should be all that is needed - look in xen_unlock_kick. The
rest of the spinlock code is all generic that is shared between
KVM, Xen and baremetal.

You should be able to run all of this under an HVM guests as well - as
in you don't need a pure PV guest to use the PV ticketlocks.

An easy way to install/run this is to install your latest distro,
do 'yum install xen' or 'apt-get install xen'. Reboot and you
are under Xen. Launch guests, etc with your favorite virtualization
toolstack.
> 
> The queue spinlock has slightly better performance than the ticket
> spinlock in uncontended case. Its performance can be much better
> with moderate to heavy contention.  This patch has the potential of
> improving the performance of all the workloads that have moderate to
> heavy spinlock contention.
> 
> The queue spinlock is especially suitable for NUMA machines with at
> least 2 sockets, though noticeable performance benefit probably won't
> show up in machines with less than 4 sockets.
> 
> The purpose of this patch set is not to solve any particular spinlock
> contention problems. Those need to be solved by refactoring the code
> to make more efficient use of the lock or finer granularity ones. The
> main purpose is to make the lock contention problems more tolerable
> until someone can spend the time and effort to fix them.
> 
> Waiman Long (8):
>   qspinlock: Introducing a 4-byte queue spinlock implementation
>   qspinlock, x86: Enable x86-64 to use queue spinlock
>   qspinlock, x86: Add x86 specific optimization for 2 contending tasks
>   pvqspinlock, x86: Allow unfair spinlock in a real PV environment
>   pvqspinlock, x86: Enable unfair queue spinlock in a KVM guest
>   pvqspinlock, x86: Rename paravirt_ticketlocks_enabled
>   pvqspinlock, x86: Add qspinlock para-virtualization support
>   pvqspinlock, x86: Enable KVM to use qspinlock's PV support
> 
>  arch/x86/Kconfig                      |   12 +
>  arch/x86/include/asm/paravirt.h       |    9 +-
>  arch/x86/include/asm/paravirt_types.h |   12 +
>  arch/x86/include/asm/pvqspinlock.h    |  176 ++++++++++
>  arch/x86/include/asm/qspinlock.h      |  133 +++++++
>  arch/x86/include/asm/spinlock.h       |    9 +-
>  arch/x86/include/asm/spinlock_types.h |    4 +
>  arch/x86/kernel/Makefile              |    1 +
>  arch/x86/kernel/kvm.c                 |   73 ++++-
>  arch/x86/kernel/paravirt-spinlocks.c  |   15 +-
>  arch/x86/xen/spinlock.c               |    2 +-
>  include/asm-generic/qspinlock.h       |  122 +++++++
>  include/asm-generic/qspinlock_types.h |   61 ++++
>  kernel/Kconfig.locks                  |    7 +
>  kernel/locking/Makefile               |    1 +
>  kernel/locking/qspinlock.c            |  610 +++++++++++++++++++++++++++++++++
>  16 files changed, 1239 insertions(+), 8 deletions(-)
>  create mode 100644 arch/x86/include/asm/pvqspinlock.h
>  create mode 100644 arch/x86/include/asm/qspinlock.h
>  create mode 100644 include/asm-generic/qspinlock.h
>  create mode 100644 include/asm-generic/qspinlock_types.h
>  create mode 100644 kernel/locking/qspinlock.c
> 
