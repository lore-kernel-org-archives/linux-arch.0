Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:59246 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760724AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/13] ARM: atomic: fix gcc-4.4 build
Date: Fri, 16 Dec 2016 11:56:27 +0100
Message-ID: <20161216105634.235457-7-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105627.SMOZ_hl5Xmm32m4Jo64C_zBffDZm8u8hVOYmwEE0yKo@z>

gcc-4.4 fails to build some files with this constraint, which was
added to help out with gcc-4.6 and higher:

fs/btrfs/delayed-ref.c: In function 'add_delayed_tree_ref':
arch/arm/include/asm/atomic.h:280: error: 'asm' operand requires impossible reload

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44492
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/atomic.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 66d0e215a773..65d5b843831a 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -280,7 +280,10 @@ static inline long long atomic64_read(const atomic64_t *v)
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrd	%0, %H0, [%1]"
 	: "=&r" (result)
-	: "r" (&v->counter), "Qo" (v->counter)
+	: "r" (&v->counter)
+#if GCC_VERSION >= 40600
+	, "Qo" (v->counter)
+#endif
 	);
 
 	return result;
@@ -302,7 +305,10 @@ static inline long long atomic64_read(const atomic64_t *v)
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrexd	%0, %H0, [%1]"
 	: "=&r" (result)
-	: "r" (&v->counter), "Qo" (v->counter)
+	: "r" (&v->counter)
+#if GCC_VERSION >= 40600
+	, "Qo" (v->counter)
+#endif
 	);
 
 	return result;
-- 
2.9.0

