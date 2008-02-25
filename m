Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15386 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYBYQ4c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2008 11:56:32 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1PGuWPI144476
	for <linux-arch@vger.kernel.org>; Mon, 25 Feb 2008 16:56:32 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1PGuVI31335426
	for <linux-arch@vger.kernel.org>; Mon, 25 Feb 2008 17:56:31 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1PGuU0Y007411
	for <linux-arch@vger.kernel.org>; Mon, 25 Feb 2008 16:56:31 GMT
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080225132648.GA13791@digi.com>
References: <20080225132648.GA13791@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 25 Feb 2008 17:56:22 +0100
Message-Id: <1203958582.3247.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Mon, 2008-02-25 at 14:26 +0100, Uwe Kleine-König wrote:
> I see the following:
> 
> 	/ # for i in 1 2 3; do grep PageTables /proc/meminfo; done
> 	PageTables:          4 kB
> 	PageTables:   4294967292 kB
> 	PageTables:   4294967284 kB
> 
> and I bisected it down to 2f569af (CONFIG_HIGHPTE vs. sub-page page
> tables.)  This still happens in 2.6.25-rc3.
> 
> I have not investigated further, so I cannot tell if it's only the
> output in meminfo that is broken.
> 
> This is on ARCH=arm, on a Digi cc9p9360 with ns9xxx_defconfig.

Hmm, not good. The number obviously went negative. There is an imbalance
in the number of pgtable_page_ctor vs. pgtable_page_dtor. Could you try
this patch and watch for warnings?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
diff --git a/include/asm-arm/pgalloc.h b/include/asm-arm/pgalloc.h
index 163b030..eeb973a 100644
--- a/include/asm-arm/pgalloc.h
+++ b/include/asm-arm/pgalloc.h
@@ -94,6 +94,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
+	WARN_ON(!pte);
 	pgtable_page_dtor(pte);
 	__free_page(pte);
 }


