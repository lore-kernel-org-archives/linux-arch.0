Return-Path: <sky@de.ibm.com>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:48818 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S263730AbUDGQZo
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Apr 2004 12:25:44 -0400
Date: Wed, 7 Apr 2004 18:23:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] missing NULL pointer check in pte_alloc_one.
Message-ID: <20040407162319.GA2274@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andrew,
stupid cut-copy-paste error. I fixed the problem for alpha and sparc64
but I broke s390. pte_alloc_one shouldn't allocate two pages, return one
and forget the other without freeing it...

blue skies,
  Martin.

diff -urN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-pgalloc/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	Wed Apr  7 18:17:19 2004
+++ linux-2.6-pgalloc/include/asm-s390/pgalloc.h	Wed Apr  7 18:16:50 2004
@@ -141,7 +141,7 @@
 {
 	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
 	if (pte)
-		return virt_to_page(pte_alloc_one_kernel(mm, vmaddr));
+		return virt_to_page(pte);
 	return 0;
 }
 
