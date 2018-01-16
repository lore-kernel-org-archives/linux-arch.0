From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 06/22] signal: Remove _sys_private and _overrun_incr from struct compat_siginfo
Date: Mon, 15 Jan 2018 18:39:53 -0600
Message-ID: <20180116004009.31036-6-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

We have never passed either field to or from userspace so just remove them.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/compat.h   | 1 -
 arch/parisc/include/asm/compat.h  | 1 -
 arch/powerpc/include/asm/compat.h | 1 -
 arch/s390/include/asm/compat.h    | 1 -
 arch/sparc/include/asm/compat.h   | 1 -
 arch/tile/include/asm/compat.h    | 2 --
 arch/x86/include/asm/compat.h     | 2 --
 arch/x86/kernel/signal_compat.c   | 2 +-
 8 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index a3c7f271ad4c..dd32fe19ec58 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -174,7 +174,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index acf8aa07cbe0..cf3bcacec027 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -155,7 +155,6 @@ typedef struct compat_siginfo {
 			int _overrun;           /* overrun count */
 			char _pad[sizeof(unsigned int) - sizeof(int)];
 			compat_sigval_t _sigval;        /* same as below */
-			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 8a2aecfe9b02..e02de2fd56e3 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -145,7 +145,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;		/* timer id */
 			int _overrun;			/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 5e6a63641a5f..3a187c4932a5 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -213,7 +213,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;		/* timer id */
 			int _overrun;			/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index fa38c78de0f0..2d9f4fd5f74a 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -175,7 +175,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;		/* timer id */
 			int _overrun;			/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index 62a7b83025dd..59ab9fa784b3 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -136,8 +136,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-			int _overrun_incr;	/* amount to add to overrun */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 2cbd75dd2fd3..1b6886a78562 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -151,8 +151,6 @@ typedef struct compat_siginfo {
 			compat_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-			int _overrun_incr;	/* amount to add to overrun */
 		} _timer;
 
 		/* POSIX.1b signals */
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 8c6da1a643da..85425ea30661 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -64,7 +64,7 @@ static inline void signal_compat_build_tests(void)
 	CHECK_SI_SIZE   (_kill, 2*sizeof(int));
 
 	CHECK_CSI_OFFSET(_timer);
-	CHECK_CSI_SIZE  (_timer, 5*sizeof(int));
+	CHECK_CSI_SIZE  (_timer, 3*sizeof(int));
 	CHECK_SI_SIZE   (_timer, 6*sizeof(int));
 
 	CHECK_CSI_OFFSET(_rt);
-- 
2.14.1
