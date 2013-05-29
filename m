Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57605 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935228Ab3E2WE4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 18:04:56 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so9503981pdj.38
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2013 15:04:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130529175125.GJ12193@twins.programming.kicks-ass.net>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
 <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
 <51A45861.1010008@gmail.com> <20130529122728.GA27176@twins.programming.kicks-ass.net>
 <51A5F7A7.5020604@synopsys.com> <20130529175125.GJ12193@twins.programming.kicks-ass.net>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 29 May 2013 23:04:35 +0100
Message-ID: <CAHkRjk7GeAyuMWM2B-sxDZL5qZ6Lgmh_v+vuf98+6hdro5B7ng@mail.gmail.com>
Subject: Re: TLB and PTE coherency during munmap
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Max Filippov <jcmvbkbc@gmail.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Ralf Baechle <ralf@linux-mips.org>, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>, linux-xtensa@linux-xtensa.org, Hugh Dickins <hughd@google.com>
Message-ID: <20130529220435.30o0PpuRbN0J4QnGL6pswAxQO1TOimgbPHR2tH38Onw@z>

On 29 May 2013 18:51, Peter Zijlstra <peterz@infradead.org> wrote:
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -384,6 +384,21 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
>
>  #endif /* CONFIG_HAVE_RCU_TABLE_FREE */
>
> +static inline void cond_resched_tlb(struct mmu_gather *tlb)
> +{
> +#ifndef CONFIG_PREEMPT
> +       /*
> +        * For full preempt kernels we must do regular batching like
> +        * SMP, see tlb_fast_mode(). For !PREEMPT we can 'cheat' and
> +        * do a flush before our voluntary 'yield'.
> +        */
> +       if (need_resched()) {
> +               tlb_flush_mmu(tlb);
> +               cond_resched();
> +       }
> +#endif
> +}

Does it matter that in the CONFIG_PREEMPT case, you no longer call
cond_resched()? I guess we can just rely on the kernel full preemption
to reschedule as needed.

--
Catalin
