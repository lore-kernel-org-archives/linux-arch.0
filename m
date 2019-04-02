From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Tue, 2 Apr 2019 11:43:20 +0200
Message-ID: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, steven.sistare@oracle.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 01, 2019 at 10:36:19AM -0400, Waiman Long wrote:
> On 03/29/2019 11:20 AM, Alex Kogan wrote:
> > +config NUMA_AWARE_SPINLOCKS
> > +	bool "Numa-aware spinlocks"
> > +	depends on NUMA
> > +	default y
> > +	help
> > +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> > +	  the slow path of spinlocks.
> > +
> > +	  The kernel will try to keep the lock on the same node,
> > +	  thus reducing the number of remote cache misses, while
> > +	  trading some of the short term fairness for better performance.
> > +
> > +	  Say N if you want absolute first come first serve fairness.
> > +
> 
> The patch that I am looking for is to have a separate
> numa_queued_spinlock_slowpath() that coexists with
> native_queued_spinlock_slowpath() and
> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
> appropriate one for the system at hand.

Agreed; and until we have static_call, I think we can abuse the paravirt
stuff for this.

By the time we patch the paravirt stuff:

  check_bugs()
    alternative_instructions()
      apply_paravirt()

we should already have enumerated the NODE topology and so nr_node_ids()
should be set.

So if we frob pv_ops.lock.queued_spin_lock_slowpath to
numa_queued_spin_lock_slowpath before that, it should all get patched
just right.

That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
PARAVIRT_SPINLOCK, which is a bit awkward...
