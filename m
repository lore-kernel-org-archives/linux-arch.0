From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: RFC: remove ibcs2/PER_SVR4?
Date: Wed, 01 Oct 2008 10:45:41 +0200
Message-ID: <1222850741.32562.4.camel@localhost>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56455 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbYJAJB3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Oct 2008 05:01:29 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9191OJa078514
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 09:01:24 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9191Oji3301584
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 11:01:24 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9191NcA032206
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 11:01:24 +0200
Received: from [9.152.198.52] (dyn-9-152-198-52.boeblingen.de.ibm.com [9.152.198.52])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m9191NlR032200
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 11:01:23 +0200
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Greetings,
I stumbled across SET_PERSONALITY and the ibcs2/PER_SVR4 personality once
more. I never really understood why it is there and with the current code
it is in fact completely unused. The minimal patch I will do is the one
below, it just removes ibcs2/PER_SVR4 for s390. I think the same could be
done for all architectures and the SET_PERSONALITY macro could drop the
ibcs2 argument. Before I go ahead and do a patch across all architectures:
does anybody out there still needs ibcs2/PER_SVR4?

--
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
---
Subject: [PATCH] remove unused ibcs2/PER_SVR4 in SET_PERSONALITY

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

There is no PER_SVR4 personality for s390 and the SET_PERSONALITY macros is
always called with ibcs2==0. Remove the useless code.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/elf.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/include/asm/elf.h linux-2.6-patched/arch/s390/include/asm/elf.h
--- linux-2.6/arch/s390/include/asm/elf.h	2008-10-01 10:02:09.000000000 +0200
+++ linux-2.6-patched/arch/s390/include/asm/elf.h	2008-10-01 10:25:38.000000000 +0200
@@ -170,13 +170,11 @@ extern char elf_platform[];
 #define ELF_PLATFORM (elf_platform)
 
 #ifndef __s390x__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX)
 #else /* __s390x__ */
 #define SET_PERSONALITY(ex, ibcs2)			\
 do {							\
-	if (ibcs2)					\
-		set_personality(PER_SVR4);		\
-	else if (current->personality != PER_LINUX32)	\
+	if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
 		set_thread_flag(TIF_31BIT);		\
