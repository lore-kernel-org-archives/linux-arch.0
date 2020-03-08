From: Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't
 kick isolated cpus
Date: Sun, 8 Mar 2020 06:48:43 +0000
Message-ID: <7e0ce8988f4811e7453859e22654d2618557d9ab.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
 <20200306153446.GC8590@lenoir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200306153446.GC8590@lenoir>
Content-Language: en-US
Content-ID: <22B91EB6759F5E429B9A26A5E13F7A1A@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: "frederic@kernel.org" <frederic@kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, Prasun Kapoor <pkapoor@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2020-03-06 at 16:34 +0100, Frederic Weisbecker wrote:
> On Wed, Mar 04, 2020 at 04:15:24PM +0000, Alex Belits wrote:
> > From: Yuri Norov <ynorov@marvell.com>
> > 
> > Make sure that kick_all_cpus_sync() does not call CPUs that are
> > running
> > isolated tasks.
> > 
> > Signed-off-by: Alex Belits <abelits@marvell.com>
> > ---
> >  kernel/smp.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 3a8bcbdd4ce6..d9b4b2fedfed 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -731,9 +731,21 @@ static void do_nothing(void *unused)
> >   */
> >  void kick_all_cpus_sync(void)
> >  {
> > +	struct cpumask mask;
> > +
> >  	/* Make sure the change is visible before we kick the cpus */
> >  	smp_mb();
> > -	smp_call_function(do_nothing, NULL, 1);
> > +
> > +	preempt_disable();
> > +#ifdef CONFIG_TASK_ISOLATION
> > +	cpumask_clear(&mask);
> > +	task_isolation_cpumask(&mask);
> > +	cpumask_complement(&mask, &mask);
> > +#else
> > +	cpumask_setall(&mask);
> > +#endif
> > +	smp_call_function_many(&mask, do_nothing, NULL, 1);
> > +	preempt_enable();
> >  }
> 
> That looks very dangerous, the callers of kick_all_cpus_sync() want
> to
> sync all CPUs for a reason. You will rather need to fix the callers.

All callers of this use this function to synchronize IPIs and icache,
and they have no idea if there is anything special about the state of
CPUs. If a task is isolated, this call would not be necessary because
the task is in userspace, and it would have to enter kernel for any of
that to become relevant but then it will have to switch from userspace
to kernel. At worst it is returning to userspace after entering
isolation or back in kernel running cleanup after isolation is broken
but before tsk_thread_flags_cache is updated. There will be nothing to
run on the same CPU because we have just left isolation, so task will
either exit or go back to userspace.

Is there any reason for a race at that point?

> Thanks.
> 
> >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> >  
> > -- 
> > 2.20.1
> > 

-- 
Alex
