From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Mon, 25 Sep 2017 12:42:48 +0000 (UTC)
Message-ID: <1129684352.17606.1506343368896.JavaMail.zimbra@efficios.com>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com> <20170922085959.GG10893@tardis> <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com> <20170924133038.GA8673@tardis> <1879888051.17397.1506262984228.JavaMail.zimbra@efficios.com> <20170925121054.fqtqkzmwswgjyt75@tardis> <20170925122510.2uxm54thizcupgpk@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:56903 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933476AbdIYMlp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2017 08:41:45 -0400
In-Reply-To: <20170925122510.2uxm54thizcupgpk@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>

----- On Sep 25, 2017, at 8:25 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Sep 25, 2017 at 08:10:54PM +0800, Boqun Feng wrote:
>> > static void membarrier_register_private_expedited(void)
>> > {
>> >         struct task_struct *p = current;
>> > 
>> >         if (READ_ONCE(p->mm->membarrier_private_expedited))
>> >                 return;
>> >         membarrier_arch_register_private_expedited(p);
> 
> Should we not then also do:
> 
>	    barrier();
> 
>> >         WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
>> > }
> 
> to avoid the compiler lifting that store?

membarrier_arch_register_private_expedited() being a function call, I
recall compilers cannot move load/stores across those. Moreover, even if
that function would happen to be eventually inlined, synchronize_sched()
is needed at the end of the function to ensure the scheduler will observe
the thread flags before it returns. That too would then act as a compiler
barrier if that function is ever inlined in the future.

So do you think we should still add the barrier() as documentation, or is
having synchronize_sched() in the callee enough ?

By the way, I think I should add a READ_ONCE() in membarrier_private_expedited
to pair with the WRITE_ONCE() in registration, such as:

        if (!READ_ONCE(current->mm->membarrier_private_expedited))
                return -EPERM;

Thanks!

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
