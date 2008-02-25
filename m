Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail29.messagelabs.com ([216.82.249.147]:46823 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752613AbYBYPcP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2008 10:32:15 -0500
Date: Mon, 25 Feb 2008 16:32:08 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080225153208.GA15734@digi.com>
References: <20080225132648.GA13791@digi.com> <20080225133846.GA9945@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080225133846.GA9945@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

Hello,

Russell King wrote:
> On Mon, Feb 25, 2008 at 02:26:48PM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > I see the following:
> > 
> > 	/ # for i in 1 2 3; do grep PageTables /proc/meminfo; done
> > 	PageTables:          4 kB
> > 	PageTables:   4294967292 kB
> > 	PageTables:   4294967284 kB
> > 
> > and I bisected it down to 2f569af (CONFIG_HIGHPTE vs. sub-page page
> > tables.)  This still happens in 2.6.25-rc3.
> > 
> > I have not investigated further, so I cannot tell if it's only the
> > output in meminfo that is broken.
> > 
> > This is on ARCH=arm, on a Digi cc9p9360 with ns9xxx_defconfig.
> 
> Note that there's been other reports of this on other ARM platforms as
> well.
I didn't see these.  @Russell: can you point me to these reports?

With the patch below, I get two times printascii('-'), zero times
printascii('+') and the following two stacktraces:

	[<c0120330>] (dump_stack+0x0/0x14) from [<c01232ec>] (free_pgd_slow+0xa4/0x10c)
	[<c0123248>] (free_pgd_slow+0x0/0x10c) from [<c01318d8>] (__mmdrop+0x24/0x54)
	 r7:c1c88000 r6:c14d8cc0 r5:c1c4cc40 r4:c14d8cc0
	[<c01318b4>] (__mmdrop+0x0/0x54) from [<c01319b4>] (mmput+0xac/0xc4)
	 r4:c14d8cc0
	[<c0131908>] (mmput+0x0/0xc4) from [<c018318c>] (flush_old_exec+0x320/0x680)
	 r4:c14d8b60
	[<c0182e6c>] (flush_old_exec+0x0/0x680) from [<c01b0460>] (load_elf_binary+0x3d4/0x15d0)
	[<c01b008c>] (load_elf_binary+0x0/0x15d0) from [<c0183af4>] (search_binary_handler+0xa4/0x1fc)
	[<c0183a50>] (search_binary_handler+0x0/0x1fc) from [<c0183db0>] (do_execve+0x164/0x188)
	[<c0183c4c>] (do_execve+0x0/0x188) from [<c011fb94>] (sys_execve+0x3c/0x5c)
	 r8:c011cb44 r7:c1c24000 r6:c1c89fb0 r5:0008cba8 r4:c1c24000
	[<c011fb58>] (sys_execve+0x0/0x5c) from [<c011c9a0>] (ret_fast_syscall+0x0/0x2c)
	 r7:0000000b r6:00000001 r5:0008cb88 r4:0008cba0

	[<c0120330>] (dump_stack+0x0/0x14) from [<c01232ec>] (free_pgd_slow+0xa4/0x10c)
	[<c0123248>] (free_pgd_slow+0x0/0x10c) from [<c01318d8>] (__mmdrop+0x24/0x54)
	 r7:c1c4cc40 r6:c14d8e20 r5:00000040 r4:c14d8b60
	[<c01318b4>] (__mmdrop+0x0/0x54) from [<c012d204>] (finish_task_switch+0x8c/0x90)
	 r4:c1c4cc40
	[<c012d178>] (finish_task_switch+0x0/0x90) from [<c0215614>] (schedule+0x1c0/0x2b0)
	 r5:c1c13bc0 r4:c14d8b60
	[<c0215454>] (schedule+0x0/0x2b0) from [<c01363d4>] (do_wait+0x278/0xbb0)
	[<c013615c>] (do_wait+0x0/0xbb0) from [<c0136da4>] (sys_wait4+0x98/0xd4)
	[<c0136d0c>] (sys_wait4+0x0/0xd4) from [<c011c9a0>] (ret_fast_syscall+0x0/0x2c)
	 r8:c011cb44 r7:00000072 r6:00075989 r5:00000000 r4:00090288

when executing /bin/true.  I assume these are the two entries that go
missing?  Maybe this helps someone with a deeper understanding?

IMHO the last hunk is worth to make it into mainstream.

Best regards
Uwe

diff --git a/include/asm-arm/pgalloc.h b/include/asm-arm/pgalloc.h
index 163b030..0c85d94 100644
--- a/include/asm-arm/pgalloc.h
+++ b/include/asm-arm/pgalloc.h
@@ -75,7 +75,7 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 	if (pte) {
 		void *page = page_address(pte);
 		clean_dcache_area(page, sizeof(pte_t) * PTRS_PER_PTE);
-		pgtable_page_ctor(pte);
+		//pgtable_page_ctor(pte);
 	}
 
 	return pte;
@@ -94,7 +94,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
-	pgtable_page_dtor(pte);
+	//pgtable_page_dtor(pte);
 	__free_page(pte);
 }
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 75370ec..5553d3f 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -225,8 +225,13 @@ static inline void __mod_zone_page_state(struct zone *zone,
 	zone_page_state_add(delta, zone, item);
 }
 
+void printch(char);
 static inline void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
+	if (item == NR_PAGETABLE) {
+		printch('+');
+	}
+
 	atomic_long_inc(&zone->vm_stat[item]);
 	atomic_long_inc(&vm_stat[item]);
 }
@@ -239,6 +244,11 @@ static inline void __inc_zone_page_state(struct page *page,
 
 static inline void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 {
+	if (item == NR_PAGETABLE) {
+		printch('-');
+		dump_stack();
+	}
+
 	atomic_long_dec(&zone->vm_stat[item]);
 	atomic_long_dec(&vm_stat[item]);
 }
@@ -246,8 +256,7 @@ static inline void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 static inline void __dec_zone_page_state(struct page *page,
 			enum zone_stat_item item)
 {
-	atomic_long_dec(&page_zone(page)->vm_stat[item]);
-	atomic_long_dec(&vm_stat[item]);
+	__dec_zone_state(page_zone(page), item);
 }
 
 /*

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
