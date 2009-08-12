From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 3/3] spinlock: allow inlined spinlocks on s390
Date: Wed, 12 Aug 2009 20:39:37 +0200
Message-ID: <20090812184026.257990579@de.ibm.com>
References: <20090812183934.777715527@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:35177 "EHLO
	mtagate6.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZHLSl1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2009 14:41:27 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate6.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7CIeSaX107728
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 18:40:28 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7CIeSnY1384544
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 19:40:28 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7CIeQB7020202
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2009 19:40:28 +0100
Content-Disposition: inline; filename=03_spinlock_s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
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
