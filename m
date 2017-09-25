From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Mon, 25 Sep 2017 14:25:10 +0200
Message-ID: <20170925122510.2uxm54thizcupgpk@hirez.programming.kicks-ass.net>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922085959.GG10893@tardis>
 <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com>
 <20170924133038.GA8673@tardis>
 <1879888051.17397.1506262984228.JavaMail.zimbra@efficios.com>
 <20170925121054.fqtqkzmwswgjyt75@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbdIYMZ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2017 08:25:28 -0400
Content-Disposition: inline
In-Reply-To: <20170925121054.fqtqkzmwswgjyt75@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Sep 25, 2017 at 08:10:54PM +0800, Boqun Feng wrote:
> > static void membarrier_register_private_expedited(void)
> > {
> >         struct task_struct *p = current;
> > 
> >         if (READ_ONCE(p->mm->membarrier_private_expedited))
> >                 return;
> >         membarrier_arch_register_private_expedited(p);

Should we not then also do:

	    barrier();

> >         WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
> > }

to avoid the compiler lifting that store?
