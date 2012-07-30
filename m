From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] add mm argument to lazy mmu mode hooks
Date: Mon, 30 Jul 2012 10:15:18 +0200
Message-ID: <20120730101518.71130b33@de.ibm.com>
References: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
	<1343317634-13197-2-git-send-email-schwidefsky@de.ibm.com>
	<20120727165749.GB7190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:40335 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2G3IPp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jul 2012 04:15:45 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Mon, 30 Jul 2012 09:15:44 +0100
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6U8FLCk2752530
	for <linux-arch@vger.kernel.org>; Mon, 30 Jul 2012 09:15:21 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6U8FKBZ008368
	for <linux-arch@vger.kernel.org>; Mon, 30 Jul 2012 02:15:21 -0600
In-Reply-To: <20120727165749.GB7190@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Fri, 27 Jul 2012 12:57:50 -0400
Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:

> On Thu, Jul 26, 2012 at 05:47:13PM +0200, Martin Schwidefsky wrote:
> > To enable lazy TLB flush schemes with a scope limited to a single
> > mm_struct add the mm pointer as argument to the three lazy mmu mode
> > hooks.
> > 
> > diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> > index 0b47ddb..b097945 100644
> > --- a/arch/x86/include/asm/paravirt.h
> > +++ b/arch/x86/include/asm/paravirt.h
> > @@ -694,17 +694,17 @@ static inline void arch_end_context_switch(struct task_struct *next)
> >  }
> >  
> >  #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> > -static inline void arch_enter_lazy_mmu_mode(void)
> > +static inline void arch_enter_lazy_mmu_mode(struct mm_struct *mm)
> >  {
> >  	PVOP_VCALL0(pv_mmu_ops.lazy_mode.enter);
> 
> If you are doing that, you should probably also update the pvops call to
> pass in the 'struct mm_struct'?
> 

Seems reasonable, if we limit the lazy mmu flushing to a single mm then
that fact should be represented on the pvops calls as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
