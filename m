From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 4/4] spinlock: allow inline spinlocks on s390
Date: Tue, 11 Aug 2009 14:48:00 +0200
Message-ID: <20090811124913.385678306@de.ibm.com>
References: <20090811124756.873490673@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:40267 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZHKMuC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 08:50:02 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.14.3/8.13.8) with ESMTP id n7BCnEkW489406
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 12:49:14 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7BCnET52539638
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 14:49:14 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7BCnDXW014004
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 14:49:14 +0200
Content-Disposition: inline; filename=04_spinlock_s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig
+++ linux-2.6/arch/s390/Kconfig
@@ -93,6 +93,7 @@ config S390
 	select HAVE_KRETPROBES
 	select HAVE_KVM if 64BIT
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SPINLOCK_INLINE_SUPPORT
 	select INIT_ALL_POSSIBLE
 	select HAVE_PERF_COUNTERS
 	select GENERIC_ATOMIC64 if !64BIT

-- 
