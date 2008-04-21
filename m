From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Mon, 21 Apr 2008 16:35:47 +0200
Message-ID: <1208788547.7115.204.camel@twins>
References: <20080328025455.GA8083@wotan.suse.de>
	 <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>
	 <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org>
	 <480C81C4.8030200@qumranet.com> <1208781013.7115.173.camel@twins>
	 <480C9619.2050201@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <480C9619.2050201-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>

On Mon, 2008-04-21 at 16:26 +0300, Avi Kivity wrote:
> Peter Zijlstra wrote:
> > On Mon, 2008-04-21 at 15:00 +0300, Avi Kivity wrote:
> >   
> >> Linus Torvalds wrote:
> >>     
> >>> Finally, I don't think that comment is correct in the first place. It's 
> >>> not that simple. The thing is, even *with* the memory barrier in place, we 
> >>> may have:
> >>>
> >>> 	CPU#1			CPU#2
> >>> 	=====			=====
> >>>
> >>> 	fast_gup:
> >>> 	 - read low word
> >>>
> >>> 				native_set_pte_present:
> >>> 				 - set low word to 0
> >>> 				 - set high word to new value
> >>>
> >>> 	 - read high word
> >>>
> >>> 				- set low word to new value
> >>>
> >>> and so you read a low word that is associated with a *different* high 
> >>> word! Notice?
> >>>
> >>> So trivial memory ordering is _not_ enough.
> >>>
> >>> So I think the code literally needs to be something like this
> >>>
> >>> 	#ifdef CONFIG_X86_PAE
> >>>
> >>> 	static inline pte_t native_get_pte(pte_t *ptep)
> >>> 	{
> >>> 		pte_t pte;
> >>>
> >>> 	retry:
> >>> 		pte.pte_low = ptep->pte_low;
> >>> 		smp_rmb();
> >>> 		pte.pte_high = ptep->pte_high;
> >>> 		smp_rmb();
> >>> 		if (unlikely(pte.pte_low != ptep->pte_low)
> >>> 			goto retry;
> >>> 		return pte;
> >>> 	}
> >>>
> >>>   
> >>>       
> >> I think this is still broken.  Suppose that after reading pte_high 
> >> native_set_pte() is called again on another cpu, changing pte_low back 
> >> to the original value (but with a different pte_high).  You now have 
> >> pte_low from second native_set_pte() but pte_high from the first 
> >> native_set_pte().
> >>     
> >
> > I think the idea was that for user pages we only use set_pte_present()
> > which does the low=0 thing first.
> >   
> 
> Doesn't matter.  The second native_set_pte() (or set_pte_present()) 
> executes atomically:
> 
> 
> 	fast_gup:
> 	 - read low word (l0)
> 
> 				native_set_pte_present:
> 				 - set low word to 0
> 				 - set high word to new value (h1)
> 	 			 - set low word to new value (l1)
>  
> 
> 	 - read high word (h1)
> 
> 				native_set_pte_present:
> 				 - set low word to 0
> 				 - set high word to new value (h2)
> 	 			 - set low word to new value (l2)
> 
>    	 - re-read low word (l2)
> 
> 
> If l2 happens to be equal to l0, then the check succeeds and we have a 
> splintered pte h1:l0.

ok, so lets use cmpxchg8.

Index: linux-2.6/arch/x86/mm/gup.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/gup.c
+++ linux-2.6/arch/x86/mm/gup.c
@@ -9,6 +9,19 @@
 #include <linux/vmstat.h>
 #include <asm/pgtable.h>
 
+#ifdef CONFIG_X86_PAE
+
+static inline pte_t native_get_pte(pte_t *ptep)
+{
+	return native_make_pte(cmpxchg64((u64 *)ptep, 0ULL, 0ULL));
+}
+
+#else
+
+#define native_get_pte(ptep) (*(ptep))
+
+#endif
+
 /*
  * The performance critical leaf functions are made noinline otherwise gcc
  * inlines everything into a single function which results in too much
@@ -27,16 +40,7 @@ static noinline int gup_pte_range(pmd_t 
 
 	ptep = pte_offset_map(&pmd, addr);
 	do {
-		/*
-		 * XXX: careful. On 3-level 32-bit, the pte is 64 bits, and
-		 * we need to make sure we load the low word first, then the
-		 * high. This means _PAGE_PRESENT should be clear if the high
-		 * word was not valid. Currently, the C compiler can issue
-		 * the loads in any order, and I don't know of a wrapper
-		 * function that will do this properly, so it is broken on
-		 * 32-bit 3-level for the moment.
-		 */
-		pte_t pte = *ptep;
+		pte_t pte = native_get_pte(ptep);
 		struct page *page;
 
 		if ((pte_val(pte) & mask) != result)
