From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/22] signal: kill __ARCH_SI_UID_T
Date: Mon, 15 Jan 2018 18:39:58 -0600
Message-ID: <20180116004009.31036-11-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's always __kernel_uid32_t

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index a650d252de0a..d32f62a7f95c 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -23,10 +23,6 @@ typedef union sigval {
 #define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
 #endif
 
-#ifndef __ARCH_SI_UID_T
-#define __ARCH_SI_UID_T	__kernel_uid32_t
-#endif
-
 /*
  * The default "si_band" type is "long", as specified by POSIX.
  * However, some architectures want to override this to "int"
@@ -60,14 +56,13 @@ typedef struct siginfo {
 		/* kill() */
 		struct {
 			__kernel_pid_t _pid;	/* sender's pid */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			__kernel_uid32_t _uid;	/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
 		struct {
 			__kernel_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
-			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
 			sigval_t _sigval;	/* same as below */
 			int _sys_private;       /* not to be passed to user */
 		} _timer;
@@ -75,14 +70,14 @@ typedef struct siginfo {
 		/* POSIX.1b signals */
 		struct {
 			__kernel_pid_t _pid;	/* sender's pid */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			__kernel_uid32_t _uid;	/* sender's uid */
 			sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
 			__kernel_pid_t _pid;	/* which child */
-			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			__kernel_uid32_t _uid;	/* sender's uid */
 			int _status;		/* exit code */
 			__ARCH_SI_CLOCK_T _utime;
 			__ARCH_SI_CLOCK_T _stime;
-- 
2.14.1
