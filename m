Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268409AbUJOTdJ@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:28123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268439AbUJOTc1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2004 15:32:27 -0400
Date: Fri, 15 Oct 2004 21:32:15 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: 4level page tables architecture porting
Message-ID: <20041015193215.GA9099@wotan.suse.de>
References: <20041015172112.73e884d9.ak@suse.de> <1097863604.13633.431.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097863604.13633.431.camel@hades.cambridge.redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, akpm@digeo.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, Oct 15, 2004 at 07:06:44PM +0100, David Woodhouse wrote:
> On Fri, 2004-10-15 at 17:21 +0200, Andi Kleen wrote:
> > ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-2.gz
> > 
> > now compiles and boots on x86-64, i386, ia64. alpha, ppc64, ppc compile too,
> > but missing hardware I'm still waiting for testers for that.
> 
> ppc64 fails thus. Sorry, I'd be more helpful but I'm a little busy
> trying to work out why some ppc64 machines also die on startup because
> some of the initrd pages seem to be marked PG_slab by the time they get
> freed.

Thanks. It looks like the TASK_SIZE there is not a multiple of PGDIR_MASK.

Does it work with this patch?


diff -u linux-2.6.9rc4-4level/mm/mmap.c-Y linux-2.6.9rc4-4level/mm/mmap.c
--- linux-2.6.9rc4-4level/mm/mmap.c-Y	2004-10-12 15:31:28.000000000 +0200
+++ linux-2.6.9rc4-4level/mm/mmap.c	2004-10-15 21:21:04.000000000 +0200
@@ -1843,7 +1843,8 @@
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, TASK_SIZE);
+	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, 
+			 (TASK_SIZE + PGDIR_SIZE - 1) & ~(PGDIR_SIZE - 1));
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
 	vma = mm->mmap;


-Andi
