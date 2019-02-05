From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 5 Feb 2019 10:22:56 +0100
Message-ID: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com, longman@redhat.com, Thomas Gleixner <tglx@linutronix.de>, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
> 
> > On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> >> Choose the next lock holder among spinning threads running on the same
> >> socket with high probability rather than always. With small probability,
> >> hand the lock to the first thread in the secondary queue or, if that
> >> queue is empty, to the immediate successor of the current lock holder
> >> in the main queue.  Thus, assuming no failures while threads hold the
> >> lock, every thread would be able to acquire the lock after a bounded
> >> number of lock transitions, with high probability.
> >> 
> >> Note that we could make the inter-socket transition deterministic,
> >> by sticking a counter of intra-socket transitions in the head node
> >> of the secondary queue. At the handoff time, we could increment
> >> the counter and check if it is below a threshold. This adds another
> >> field to queue nodes and nearly-certain local cache miss to read and
> >> update this counter during the handoff. While still beating stock,
> >> this variant adds certain overhead over the probabilistic variant.
> > 
> > (also heavily suffers from the socket == node confusion)
> > 
> > How would you suggest RT 'tunes' this?
> > 
> > RT relies on FIFO fairness of the basic spinlock primitives; you just
> > completely wrecked that.
> 
> This is true that CNA trades some fairness for shorter lock handover
> latency, much like any other NUMA-aware lock.
> 
> Can you explain, however, what exactly breaks here?

Timeliness guarantees. FIFO-fair has well defined time behaviour; you
know exactly how long you get to wait before you acquire the lock,
namely however many waiters are in front of you multiplied by the worst
case wait time.

Doing time analysis on a randomized algorithm isn't my idea of fun.

> It seems that even today, qspinlock does not support RT_PREEMPT, given
> that it uses per-CPU queue nodes.

It does work with RT, commit:

  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")

it a direct result of RT observing funnies with it. I've no idea why you
think it would not work.
