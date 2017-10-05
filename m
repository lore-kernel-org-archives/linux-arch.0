From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Date: Thu, 5 Oct 2017 21:44:32 +0000 (UTC)
Message-ID: <990593306.32305.1507239872255.JavaMail.zimbra@efficios.com>
References: <20171004213734.GA11463@linux.vnet.ibm.com> <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com> <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net> <312162.31738.1507219326334.JavaMail.zimbra@efficios.com> <20171005162101.ryhmtlc3sa72dmyr@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:55720 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEVnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2017 17:43:04 -0400
In-Reply-To: <20171005162101.ryhmtlc3sa72dmyr@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>, rostedt <rostedt@goodmis.org>, David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael

----- On Oct 5, 2017, at 12:21 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Oct 05, 2017 at 04:02:06PM +0000, Mathieu Desnoyers wrote:
>> ----- On Oct 5, 2017, at 8:12 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Wed, Oct 04, 2017 at 02:37:53PM -0700, Paul E. McKenney wrote:
>> >> diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
>> >> new file mode 100644
>> >> index 000000000000..b0d79a5f5981
>> >> --- /dev/null
>> >> +++ b/arch/powerpc/kernel/membarrier.c
>> >> @@ -0,0 +1,45 @@
>> > 
>> >> +void membarrier_arch_register_private_expedited(struct task_struct *p)
>> >> +{
>> >> +	struct task_struct *t;
>> >> +
>> >> +	if (get_nr_threads(p) == 1) {
>> >> +		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> >> +		return;
>> >> +	}
>> >> +	/*
>> >> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
>> >> +	 * fork is protected by siglock.
>> >> +	 */
>> >> +	spin_lock(&p->sighand->siglock);
>> >> +	for_each_thread(p, t)
>> >> +		set_ti_thread_flag(task_thread_info(t),
>> >> +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> > 
>> > I'm not sure this works correctly vs CLONE_VM without CLONE_THREAD.
>> 
>> The intent here is to hold the sighand siglock to provide mutual
>> exclusion against invocation of membarrier_fork(p, clone_flags)
>> by copy_process().
>> 
>> copy_process() grabs spin_lock(&current->sighand->siglock) for both
>> CLONE_THREAD and not CLONE_THREAD flags.
>> 
>> What am I missing here ?
> 
> If you do CLONE_VM without CLONE_THREAD you'll end up sharing the mm but
> you'll not be part of thread_head, so the for_each_thread() iteration
> will not find the task.

Excellent point. Please see the follow up RFC patch I posted taking care of
this matter.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
