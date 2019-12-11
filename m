Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbfLKSk6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:58 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Date: Wed, 11 Dec 2019 18:40:17 +0000
Message-ID: <20191211184027.20130-13-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191211184017.30QaEnVzFbVbUE0Sgsr0hm8BsENPEo45eSn9bo1coyE@z>

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add MTE-specific SIGSEGV codes to siginfo.h.

Note that the for MTE we are reusing the same SPARC ADI codes because
the two functionalities are similar and they cannot coexist on the same
system.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/uapi/asm-generic/siginfo.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..a5184a5438c6 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -227,8 +227,13 @@ typedef struct siginfo {
 # define SEGV_PKUERR	4	/* failed protection key checks */
 #endif
 #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
-#define SEGV_ADIDERR	6	/* Disrupting MCD error */
-#define SEGV_ADIPERR	7	/* Precise MCD exception */
+#ifdef __aarch64__
+# define SEGV_MTEAERR	6	/* Asynchronous MTE error */
+# define SEGV_MTESERR	7	/* Synchronous MTE exception */
+#else
+# define SEGV_ADIDERR	6	/* Disrupting MCD error */
+# define SEGV_ADIPERR	7	/* Precise MCD exception */
+#endif
 #define NSIGSEGV	7
 
 /*
