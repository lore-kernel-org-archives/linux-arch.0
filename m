Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	by smtps.tip.net.au (Postfix) with ESMTP id C2FDE368827
	for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2005 18:15:32 +1100 (EST)
Date: Tue, 22 Feb 2005 18:15:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] add and use COMPAT_SIGEV_PAD_SIZE
Message-Id: <20050222181530.5afa4e72.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi all,

All the 32 biut architectures (effectively) define SIGEV_PAD_SIZE to be
((SIGEV_MAX_SIZE/sizeof(int)) - 3).  So define COMPAT_SIGEV_PAD_SIZE to be
this and replace SIGEV_PAD_SIZE32 where it is used.  It also needs to be
used in the definition of struct compat_sigevent as most of the
architectures would have had it 4 bytes too small in teh kernel (since we
were using SIGEV_PAD_SIZE).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I will submit this to Andrew is it is deemed OK.  I intend to build on
this patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus.new/arch/ia64/ia32/ia32priv.h linus.new.xxx/arch/ia64/ia32/ia32priv.h
--- linus.new/arch/ia64/ia32/ia32priv.h	2005-01-05 17:06:07.000000000 +1100
+++ linus.new.xxx/arch/ia64/ia32/ia32priv.h	2005-02-21 12:02:07.000000000 +1100
@@ -230,8 +230,6 @@ typedef union sigval32 {
 	unsigned int sival_ptr;
 } sigval_t32;
 
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
-
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
@@ -289,7 +287,7 @@ typedef struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 		struct {
 			u32 _function;
 			u32 _attribute; /* really pthread_attr_t */
diff -ruNp linus.new/arch/s390/kernel/compat_linux.h linus.new.xxx/arch/s390/kernel/compat_linux.h
--- linus.new/arch/s390/kernel/compat_linux.h	2005-02-04 13:05:31.000000000 +1100
+++ linus.new.xxx/arch/s390/kernel/compat_linux.h	2005-02-21 12:02:07.000000000 +1100
@@ -199,7 +199,6 @@ struct ucontext32 {
 	compat_sigset_t		uc_sigmask;	/* mask last for extensibility */
 };
 
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 struct sigevent32 {
 	union {
 		int sival_int;
@@ -208,7 +207,7 @@ struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 		int _tid;
 		struct {
 			u32 *_function;
diff -ruNp linus.new/include/asm-sparc64/siginfo.h linus.new.xxx/include/asm-sparc64/siginfo.h
--- linus.new/include/asm-sparc64/siginfo.h	2005-01-05 17:06:08.000000000 +1100
+++ linus.new.xxx/include/asm-sparc64/siginfo.h	2005-02-21 12:02:07.000000000 +1100
@@ -4,7 +4,6 @@
 #define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
@@ -47,7 +46,7 @@ typedef struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 
 		struct {
 			u32 _function;
diff -ruNp linus.new/include/linux/compat.h linus.new.xxx/include/linux/compat.h
--- linus.new/include/linux/compat.h	2005-01-05 17:06:08.000000000 +1100
+++ linus.new.xxx/include/linux/compat.h	2005-02-21 12:02:07.000000000 +1100
@@ -93,12 +93,14 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define COMPAT_SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
+
 typedef struct compat_sigevent {
 	compat_sigval_t sigev_value;
 	compat_int_t sigev_signo;
 	compat_int_t sigev_notify;
 	union {
-		compat_int_t _pad[SIGEV_PAD_SIZE];
+		compat_int_t _pad[COMPAT_SIGEV_PAD_SIZE];
 		compat_int_t _tid;
 
 		struct {
