From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: asm/mmu.h using NR_CPUS (was Re: kisskb: FAILED
 linux-next/axs101_defconfig/arcompact Thu May 04, 18:53)
Date: Fri, 5 May 2017 11:52:32 -0700
Message-ID: <6aa3877c-9118-88d1-b662-49a455a66258@synopsys.com>
References: <20170504085336.1.21586@5b4f83badeef>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170504085336.1.21586@5b4f83badeef>
Sender: owner-linux-mm@kvack.org
To: linux-snps-arc@lists.infradead.org
Cc: noreply@ellerman.id.au, lkml <linux-kernel@vger.kernel.org>, Alexey.Brodkin@synopsys.com, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Michal Hocko <mhocko@suse.cz>, Anton Kolesov <Anton.Kolesov@synopsys.com>
List-Id: linux-arch.vger.kernel.org

+CC Michal, linux-arch as it potentially affects other arches !

Hi,

On 05/04/2017 01:53 AM, noreply@ellerman.id.au wrote:
> FAILED linux-next/axs101_defconfig/arcompact Thu May 04, 18:53
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/13022475/
> 
> Commit:   Add linux-next specific files for 20170504
>           ef57eb19c96fa099a578aeaed9b9d0dbcc4fe069
> Compiler: arc-buildroot-linux-uclibc-gcc (Buildroot 2015.08.1) 4.8.4
> 
> Possible errors
> ---------------
> 
> arch/arc/include/asm/mmu.h:75:21: error: 'NR_CPUS' undeclared here (not in a function)
> make[3]: *** [arch/arc/mm/ioremap.o] Error 1
> make[2]: *** [arch/arc/mm] Error 2
> make[1]: *** [arch/arc] Error 2
> arch/arc/include/asm/mmu.h:75:21: error: 'NR_CPUS' undeclared here (not in a function)
> make[3]: *** [kernel/irq/generic-chip.o] Error 1
> make[2]: *** [kernel/irq] Error 2
> make[1]: *** [kernel] Error 2
> arch/arc/include/asm/mmu.h:75:21: error: 'NR_CPUS' undeclared here (not in a function)
> make[2]: *** [mm/vmalloc.o] Error 1
> make[1]: *** [mm] Error 2
> make: *** [sub-make] Error 2

I bisected the linux-next ARC build failure (!SMP only) to a subtle side effect of
a950a30220657d ("mm, vmalloc: properly track vmalloc users") which includes
asm/pgtable.h causing the final include chain (for ARC ioremap.c) to have
asm/mmu.h (using NR_CPUS) before linux/threads.h (defining it)

The quick fix is to include linux/threads.h and this is just a heads up other
arches might run into same - although xtensa and mips with similar mm_context_t
seem to build just fine !

-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
