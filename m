Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268317AbUHLDxs@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:3008 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267974AbUHLDxs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 23:53:48 -0400
Date: Wed, 11 Aug 2004 20:53:02 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_page_range()
Message-Id: <20040811205302.4d7911a1.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408110856080.1839@ppc970.osdl.org>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<20040807080751.GX17188@holomorphy.com>
	<20040811000708.6e31969d.davem@redhat.com>
	<Pine.LNX.4.58.0408110856080.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 09:13:36 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Also, one comment: the page directory "index" is never zeroed, as far as I
> can tell.

It's done in the pmd/pgd freeing methods.

 static __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	virt_to_page(pgd)->index = 0UL;
+
 ...

 static __inline__ void free_pmd_fast(pmd_t *pmd)
 {
 	unsigned long color = DCACHE_COLOR((unsigned long)pmd);
+
+	virt_to_page(pmd)->index = 0UL;

and also at pmd/pgd allocation time.

> David, could you look at instead of doing this <asm/page-walk.c> thing, 
> just do a few _trivial_ macros in the asm page table headers:

I assume you mean asm/page-walk.h, and sure I'll whip something up.

But please keep in mind what I said in my other email, that
I really want to (in the end) abstract away all page table
walking, so that the only thing the generic VM code really
plays around with are pte's.  All page table traversal goes
through an interface, so platforms can use whatever data structure
(ie. something that isn't a flat out array) they want.
