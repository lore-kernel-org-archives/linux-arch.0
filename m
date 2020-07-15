From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v7 04/29] arm64: mte: Add specific SIGSEGV codes
Date: Wed, 15 Jul 2020 18:08:19 +0100
Message-ID: <20200715170844.30064-5-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGORI6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:08:58 -0400
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add MTE-specific SIGSEGV codes to siginfo.h and update the x86
BUILD_BUG_ON(NSIGSEGV != 7) compile check.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
[catalin.marinas@arm.com: dropped #ifdef __aarch64__, renumbered]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v3:
    - Fixed the BUILD_BUG_ON(NSIGSEGV != 7) on x86
    - Updated the commit log
    
    v2:
    - Dropped the #ifdef __aarch64__.
    - Renumbered the SEGV_MTE* values to avoid clash with ADI.

 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf0576cd0..a7f3e12cfbdb 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 7);
+	BUILD_BUG_ON(NSIGSEGV != 9);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..7aacf9389010 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,9 @@ typedef struct siginfo {
 #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
 #define SEGV_ADIDERR	6	/* Disrupting MCD error */
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
-#define NSIGSEGV	7
+#define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
+#define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
+#define NSIGSEGV	9
 
 /*
  * SIGBUS si_codes
