From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 17/22] signal/tile: Move the tile specific si_codes to asm-generic/siginfo.h
Date: Mon, 15 Jan 2018 18:40:04 -0600
Message-ID: <20180116004009.31036-17-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Having si_codes in many different files simply encourages duplicate definitions
that can cause problems later.  To avoid that merge the tile specific si_codes
into uapi/asm-generic/siginfo.h

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/tile/include/uapi/asm/siginfo.h | 8 --------
 include/uapi/asm-generic/siginfo.h   | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/tile/include/uapi/asm/siginfo.h b/arch/tile/include/uapi/asm/siginfo.h
index f234d24fff55..a812fcbf4267 100644
--- a/arch/tile/include/uapi/asm/siginfo.h
+++ b/arch/tile/include/uapi/asm/siginfo.h
@@ -24,12 +24,4 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * Additional Tile-specific SIGILL si_codes
- */
-#define ILL_DBLFLT	9	/* double fault */
-#define ILL_HARDWALL	10	/* user networks hardwall violation */
-#undef NSIGILL
-#define NSIGILL		10
-
 #endif /* _ASM_TILE_SIGINFO_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index f1c0af4f36a4..7a268db1c44f 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -186,6 +186,10 @@ typedef struct siginfo {
 #define ILL_PRVREG	6	/* privileged register */
 #define ILL_COPROC	7	/* coprocessor error */
 #define ILL_BADSTK	8	/* internal stack error */
+#ifdef __tile__
+# define ILL_DBLFLT	9	/* double fault */
+# define ILL_HARDWALL	10	/* user networks hardwall violation */
+#endif
 #ifdef __ia64__
 # define ILL_BADIADDR	9	/* unimplemented instruction address */
 # define __ILL_BREAK	10	/* illegal break */
-- 
2.14.1
