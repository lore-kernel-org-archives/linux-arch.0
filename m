From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Wed, 1 Apr 2015 19:42:39 +0200
Message-ID: <20150401174239.GO24151@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com>
	<20150319101242.GM21418@twins.programming.kicks-ass.net>
	<20150319122536.GD11574@worktop.ger.corp.intel.com>
	<551C1ACE.4090408@hp.com>
	<20150401171223.GO23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150401171223.GO23123@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 01, 2015 at 07:12:23PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 01, 2015 at 12:20:30PM -0400, Waiman Long wrote:
> > After more careful reading, I think the assumption that the presence of an
> > unused bucket means there is no match is not true. Consider the scenario:
> > 
> > 1. cpu 0 puts lock1 into hb[0]
> > 2. cpu 1 puts lock2 into hb[1]
> > 3. cpu 2 clears hb[0]
> > 4. cpu 3 looks for lock2 and doesn't find it
> 
> Hmm, yes. The only way I can see that being true is if we assume entries
> are never taken out again.
> 
> The wikipedia page could use some clarification here, this is not clear.
> 
> > At this point, I am thinking using back your previous idea of passing the
> > queue head information down the queue.
> 
> Having to scan the entire array for a lookup sure sucks, but the wait
> loops involved in the other idea can get us in the exact predicament we
> were trying to get out, because their forward progress depends on other
> CPUs.
> 
> Hohumm.. time to think more I think ;-)

So bear with me, I've not really pondered this well so it could be full
of holes (again).

After the cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL) succeeds the
spin_unlock() must do the hash lookup, right? We can make the lookup
unhash.

If the cmpxchg() fails the unlock will not do the lookup and we must
unhash.
