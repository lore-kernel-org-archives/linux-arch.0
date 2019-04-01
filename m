From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Mon, 1 Apr 2019 11:33:45 +0200
Message-ID: <20190401093345.GA14281@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190401090653.GF11158@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 01, 2019 at 11:06:53AM +0200, Peter Zijlstra wrote:
> On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
> > diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> > index bc6d3244e1af..71ee4b64c5d4 100644
> > --- a/kernel/locking/mcs_spinlock.h
> > +++ b/kernel/locking/mcs_spinlock.h
> > @@ -17,8 +17,18 @@
> >  
> >  struct mcs_spinlock {
> >  	struct mcs_spinlock *next;
> > +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
> >  	int locked; /* 1 if lock acquired */
> >  	int count;  /* nesting count, see qspinlock.c */
> > +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
> > +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
> > +			  /* represent a pointer to the secondary queue head */
> > +	u32 node_and_count;	/* node id on which this thread is running */
> > +				/* with two lower bits reserved for nesting */
> > +				/* count, see qspinlock.c */
> > +	u32 encoded_tail; /* encoding of this node as the main queue tail */
> > +	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
> > +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
> >  };
> 
> Please, have another look at the paravirt code, in particular at struct
> pv_node and its usage. This is horrible.

Thing is, this turns into a right mess when you also have PV spinlocks
on.

One thing we could maybe do is change locked and count to u8, then your
overlay structure could be something like:

struct mcs_spinlock {
	struct mcs_spinlock *next;
	u8 locked;
	u8 count;
};

struct cna_node {
	/* struct mcs_spinlock overlay */
	struct mcs_spinlock *next;
	u8 locked;
	u8 count;

	/* our CNA bits, consuming the slack and PV space */
	u16 node;
	u32 encoded_tail;
	struct mcs_spinlock *head;
	struct mcs_spinlock *tail;
};

Then you also don't need the first two patches.
