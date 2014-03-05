From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Wed, 5 Mar 2014 21:59:13 +0100
Message-ID: <20140305205913.GS3104@twins.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
	<20140303174305.GK9987@twins.programming.kicks-ass.net>
	<531611EA.6020200@hp.com>
	<20140304224043.GQ9987@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140304224043.GQ9987@twins.programming.kicks-ass.net>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 04, 2014 at 11:40:43PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 04, 2014 at 12:48:26PM -0500, Waiman Long wrote:
> > Peter,
> > 
> > I was trying to implement the generic queue code exchange code using
> > cmpxchg as suggested by you. However, when I gathered the performance
> > data, the code performed worse than I expected at a higher contention
> > level. Below were the execution time of the benchmark tool that I sent
> > you:
> 
> I'm just not seeing that; with test-4 modified to take the AMD compute
> units into account:

OK; I tried on a few larger machines and I can indeed see it there.

That said; our code doesn't differ that much. I see why you're not doing
too well on the 2 CPU contention. You've got an atomic op too much in
that path. But given you see benefit even with 2 atomic ops (I had mixed
results on that) we can do the pending/waiter thing unconditionally for
NR_CPUS>16k.

I also think I can do your full xchg thing without allowing lock steals.

I'll try and do a full series tomorrow that starts with simple code and
builds on that, doing each optimization one by one.
