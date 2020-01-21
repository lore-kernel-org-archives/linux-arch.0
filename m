From: Shijith Thotton <sthotton@marvell.com>
Subject: Re: [PATCH v8 0/5] Add NUMA-awareness to qspinlock
Date: Tue, 21 Jan 2020 09:21:00 +0000
Message-ID: <20200121092034.GA18209@dc5-eodlnx05.marvell.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20200108050847.GA12944@dc5-eodlnx05.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200108050847.GA12944@dc5-eodlnx05.marvell.com>
Content-Language: en-US
Content-ID: <ADD514F62B5A6C4680B5DD2D357797CB@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>, "will@kernel.org" <will@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "peterz@infradead.org" <peterz@infradead.org>, "dave.dice@oracle.com" <dave.dice@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "longman@redhat.com" <longman@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Will/Catalin,

On Wed, Jan 08, 2020 at 05:09:05AM +0000, Shijith Thotton wrote:
> On Mon, Dec 30, 2019 at 02:40:37PM -0500, Alex Kogan wrote:
> > Minor changes from v7 based on feedback from Longman:
> > -----------------------------------------------------
> > 
> > - Move __init functions from alternative.c to qspinlock_cna.h
> > 
> > - Introduce enum for return values from cna_pre_scan(), for better
> > readability.
> > 
> > - Add/revise a few comments to improve readability.
> > 
> > 
> > Summary
> > -------
> > 
> > Lock throughput can be increased by handing a lock to a waiter on the
> > same NUMA node as the lock holder, provided care is taken to avoid
> > starvation of waiters on other NUMA nodes. This patch introduces CNA
> > (compact NUMA-aware lock) as the slow path for qspinlock. It is
> > enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> > 
> > CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> > organized in two queues, a main queue for threads running on the same
> > node as the current lock holder, and a secondary queue for threads
> > running on other nodes. Threads store the ID of the node on which
> > they are running in their queue nodes. After acquiring the MCS lock and
> > before acquiring the spinlock, the lock holder scans the main queue
> > looking for a thread running on the same node (pre-scan). If found (call
> > it thread T), all threads in the main queue between the current lock
> > holder and T are moved to the end of the secondary queue.  If such T
> > is not found, we make another scan of the main queue after acquiring 
> > the spinlock when unlocking the MCS lock (post-scan), starting at the
> > node where pre-scan stopped. If both scans fail to find such T, the
> > MCS lock is passed to the first thread in the secondary queue. If the
> > secondary queue is empty, the MCS lock is passed to the next thread in the
> > main queue. To avoid starvation of threads in the secondary queue, those
> > threads are moved back to the head of the main queue after a certain
> > number of intra-node lock hand-offs.
> > 
> > More details are available at https://urldefense.proofpoint.com/v2/url?u=https-3A__arxiv.org_abs_1810.05600&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=G9w4KsPaQLACBfGCL35PtiRH996yqJDxAZwrWegU2qQ&m=AoOLTQlgNjtdBvY_yWd6ViBXrVM6o2wqXOdFA4B_F2A&s=yUjG9gfi3BtLKDEjgki86h52GVXMvDQ6ZClMvoIG034&e= .
> > 
> > The series applies on top of v5.5.0-rc2, commit ea200dec51.
> > Performance numbers are available in previous revisions
> > of the series.
> > 
> > Further comments are welcome and appreciated.
> > 
> > Alex Kogan (5):
> >   locking/qspinlock: Rename mcs lock/unlock macros and make them more
> >     generic
> >   locking/qspinlock: Refactor the qspinlock slow path
> >   locking/qspinlock: Introduce CNA into the slow path of qspinlock
> >   locking/qspinlock: Introduce starvation avoidance into CNA
> >   locking/qspinlock: Introduce the shuffle reduction optimization into
> >     CNA
> > 
> >  .../admin-guide/kernel-parameters.txt         |  18 +
> >  arch/arm/include/asm/mcs_spinlock.h           |   6 +-
> >  arch/x86/Kconfig                              |  20 +
> >  arch/x86/include/asm/qspinlock.h              |   4 +
> >  arch/x86/kernel/alternative.c                 |   4 +
> >  include/asm-generic/mcs_spinlock.h            |   4 +-
> >  kernel/locking/mcs_spinlock.h                 |  20 +-
> >  kernel/locking/qspinlock.c                    |  82 +++-
> >  kernel/locking/qspinlock_cna.h                | 400 ++++++++++++++++++
> >  kernel/locking/qspinlock_paravirt.h           |   2 +-
> >  10 files changed, 537 insertions(+), 23 deletions(-)
> >  create mode 100644 kernel/locking/qspinlock_cna.h
> > 
> > -- 
> > 2.21.0 (Apple Git-122.2)
> >
> 
> Tried out queued spinlock slowpath improvements on arm64 (ThunderX2) by
> hardwiring CNA APIs to queued_spin_lock_slowpath() and numbers are pretty
> good with the CNA changes.
> 
> Speed-up on v5.5-rc4 kernel:
> 
> will-it-scale/open1_threads:
> #thr    speed-up
> 1        1.00
> 2        0.97
> 4        0.98
> 8        1.02
> 16       0.95
> 32       1.63
> 64       1.70
> 128      2.09
> 224      2.16
> 
> will-it-scale/lock2_threads:
> #thr    speed-up
> 1        0.98
> 2        0.99
> 4        0.90   
> 8        0.98
> 16       0.99
> 32       1.52
> 64       2.31
> 128      2.25   
> 224      2.04   
> 
> #thr - number of threads
> speed-up - number with CNA patch / number with stock kernel
> 
> Please share your thoughts on best way to enable this series on arm64.

Please comment if you got a chance to look at this. 

Thanks,
Shijith
