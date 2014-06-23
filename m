From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 01/11] qspinlock: A simple generic 4-byte queue spinlock
Date: Mon, 23 Jun 2014 12:45:12 -0400
Message-ID: <20140623164512.GA9788@laptop.dumpdata.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130152.912524881@chello.nl>
	<20140617200531.GB27242@laptop.dumpdata.com>
	<20140623162622.GH19860@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140623162622.GH19860@laptop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 23, 2014 at 06:26:22PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 17, 2014 at 04:05:31PM -0400, Konrad Rzeszutek Wilk wrote:
> > > + * The basic principle of a queue-based spinlock can best be understood
> > > + * by studying a classic queue-based spinlock implementation called the
> > > + * MCS lock. The paper below provides a good description for this kind
> > > + * of lock.
> > > + *
> > > + * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
> > > + *
> > > + * This queue spinlock implementation is based on the MCS lock, however to make
> > > + * it fit the 4 bytes we assume spinlock_t to be, and preserve its existing
> > > + * API, we must modify it some.
> > > + *
> > > + * In particular; where the traditional MCS lock consists of a tail pointer
> > > + * (8 bytes) and needs the next pointer (another 8 bytes) of its own node to
> > > + * unlock the next pending (next->locked), we compress both these: {tail,
> > > + * next->locked} into a single u32 value.
> > > + *
> > > + * Since a spinlock disables recursion of its own context and there is a limit
> > > + * to the contexts that can nest; namely: task, softirq, hardirq, nmi, we can
> > > + * encode the tail as and index indicating this context and a cpu number.
> > > + *
> > > + * We can further change the first spinner to spin on a bit in the lock word
> > > + * instead of its node; whereby avoiding the need to carry a node from lock to
> > > + * unlock, and preserving API.
> > 
> > You also made changes (compared to the MCS) in that the unlock path is not
> > spinning waiting for the successor and that the job of passing the lock
> > is not done in the unlock path either.
> > 
> > Instead all of that is now done in the path of the lock acquirer logic. 
> > 
> > Could you update the comment to say that please?
> 
> I _think_ I know what you mean.. So that is actually implied by the last

You do :-)

> paragraph, but I suppose I can make it explicit; something like:
> 
>   *
>   * Another way to look at it is:
>   *
>   *  lock(tail,locked)
>   *    struct mcs_spinlock node;
>   *    mcs_spin_lock(tail, &node);
>   *    test-and-set locked;
>   *    mcs_spin_unlock(tail, &node);
>   *
>   *  unlock(tail,locked)
>   *    clear locked
>   *
>   * Where we have compressed (tail,locked) into a single u32 word.
> 
> 
