From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: TLB and PTE coherency during munmap
Date: Wed, 29 May 2013 23:04:35 +0100
Message-ID: <CAHkRjk7GeAyuMWM2B-sxDZL5qZ6Lgmh_v+vuf98+6hdro5B7ng@mail.gmail.com>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
 <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
 <51A45861.1010008@gmail.com> <20130529122728.GA27176@twins.programming.kicks-ass.net>
 <51A5F7A7.5020604@synopsys.com> <20130529175125.GJ12193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130529175125.GJ12193@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Max Filippov <jcmvbkbc@gmail.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Ralf Baechle <ralf@linux-mips.org>, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>, linux-xtensa@linux-xtensa.org, Hugh Dickins <hughd@google.com>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
