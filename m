From: Lihao Liang <lihaoliang@google.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Date: Sun, 26 Jan 2020 01:58:02 +0000
Message-ID: <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
 <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, Peter Zijlstra <peterz@infradead.org>, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 26, 2020 at 12:32 AM Lihao Liang <lihaoliang@google.com> wrote:
>
> Hi Alex and Waiman,
>
> Thanks a lot for your swift response and clarification.
>
> On Wed, Jan 22, 2020 at 7:30 PM Alex Kogan <alex.kogan@oracle.com> wrote:
> >
> > Hi, Lihao.
> >
> > > On Jan 22, 2020, at 6:45 AM, Lihao Liang <lihaoliang@google.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
> > >>
> > >> Summary
> > >> -------
> > >>
> > >> Lock throughput can be increased by handing a lock to a waiter on the
> > >> same NUMA node as the lock holder, provided care is taken to avoid
> > >> starvation of waiters on other NUMA nodes. This patch introduces CNA
> > >> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> > >> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> > >>
> > >
> > > Thanks for your patches. The experimental results look promising!
> > >
> > > I understand that the new CNA qspinlock uses randomization to achieve
> > > long-term fairness, and provides the numa_spinlock_threshold parameter
> > > for users to tune.
> > This has been the case in the first versions of the series, but is not true anymore.
> > That is, the long-term fairness is achieved deterministically (and you are correct
> > that it is done through the numa_spinlock_threshold parameter).
> >
> > > As Linux runs extremely diverse workloads, it is not
> > > clear how randomization affects its fairness, and how users with
> > > different requirements are supposed to tune this parameter.
> > >
> > > To this end, Will and I consider it beneficial to be able to answer the
> > > following question:
> > >
> > > With different values of numa_spinlock_threshold and
> > > SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> > > sockets have to wait to acquire the lock?
> > The SHUFFLE_REDUCTION_PROB_ARG parameter is intended for performance
> > optimization only, and *does not* affect the long-term fairness (or, at the
> > very least, does not make it any worse). As Longman correctly pointed out in
> > his response to this email, the shuffle reduction optimization is relevant only
> > when the secondary queue is empty. In that case, CNA hands-off the lock
> > exactly as MCS does, i.e., in the FIFO order. Note that when the secondary
> > queue is not empty, we do not call probably().
> >
> > > This is particularly relevant
> > > in high contention situations when new threads keep arriving on the same
> > > socket as the lock holder.
> > In this case, the lock will stay on the same NUMA node/socket for
> > 2^numa_spinlock_threshold times, which is the worst case scenario if we
> > consider the long-term fairness. And if we have multiple nodes, it will take
> > up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
> > lock transitions until any given thread will acquire the lock
> > (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
> >
>
> You're right that the latest version of the patch handles long-term fairness
> deterministically.
>
> As I understand it, the n-th thread in the main queue is guaranteed to
> acquire the lock after N lock handovers, where N is bounded by
>
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>
> I'm not sure what role the variable nr_cpus_per_node plays in your analysis.
>
> Do I miss anything?
>

If I understand correctly, there are two phases in the algorithm:

MCS phase: when the secondary queue is empty, as explained in your emails,
the algorithm hands the lock to threads in the main queue in an FIFO order.
When probably(SHUFFLE_REDUCTION_PROB_ARG) returns false (with default
probability 1%), if the algorithm finds the first thread running on the same
socket as the lock holder in cna_scan_main_queue(), it enters the following
CNA phase.

CNA phase: when the secondary queue is not empty, the algorithm keeps
handing the lock to threads in the main queue that run on the same socket as
the lock holder. When 2^numa_spinlock_threshold is reached, it splices
the secondary queue to the front of the main queue. And we are back to the
MCS phase above.

For the n-th thread T in the main queue, the MCS phase handles threads that
arrived in the main queue before T. In high contention situations, the CNA
phase handles two kinds of threads:

1. Threads ahead of T that run on the same socket as the lock holder when
a transition from the MCS to CNA phase was made. Assume there are m such
threads.

2. Threads that keep arriving on the same socket as the lock holder. There
are at most 2^numa_spinlock_threshold of them.

Then the number of lock handovers in the CNA phase is max(m,
2^numa_spinlock_threshold). So the total number of lock handovers before T
acquires the lock is at most

n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)

Please let me know if I misunderstand anything.

Many thanks,
Lihao.
