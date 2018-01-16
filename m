From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for clarity
Date: Mon, 15 Jan 2018 18:40:00 -0600
Message-ID: <20180116004009.31036-13-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:38148 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeAPAnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:43:39 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

The addr_lsb fields is only valid and available when the
signal is SIGBUS and the si_code is BUS_MCEERR_AR or BUS_MCEERR_AO.
Document this with a comment and place the field in the _sigfault union
to make this clear.

All of the fields stay in the same physical location so both the old
and new definitions of struct siginfo will continue to work.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/compat.h             | 12 ++++++++++--
 include/uapi/asm-generic/siginfo.h | 14 +++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8f8e3ef247de..e698ec1908d9 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -221,15 +221,23 @@ typedef struct compat_siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
-			short int _addr_lsb;	/* Valid LSB of the reported address. */
 			union {
+				/*
+				 * used when si_code=BUS_MCEERR_AR or
+				 * used when si_code=BUS_MCEERR_AO
+				 */
+				short int _addr_lsb;	/* Valid LSB of the reported address. */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
+					short _dummy_bnd;
 					compat_uptr_t _lower;
 					compat_uptr_t _upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
-				u32 _pkey;
+				struct {
+					short _dummy_pkey;
+					u32 _pkey;
+				} _addr_pkey;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d32f62a7f95c..eef4d778a5d4 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -94,15 +94,23 @@ typedef struct siginfo {
 			unsigned int _flags;	/* see ia64 si_flags */
 			unsigned long _isr;	/* isr */
 #endif
-			short _addr_lsb; /* LSB of the reported address */
 			union {
+				/*
+				 * used when si_code=BUS_MCEERR_AR or
+				 * used when si_code=BUS_MCEERR_AO
+				 */
+				short _addr_lsb; /* LSB of the reported address */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
+					short _dummy_bnd;
 					void __user *_lower;
 					void __user *_upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
-				__u32 _pkey;
+				struct {
+					short _dummy_pkey;
+					__u32 _pkey;
+				} _addr_pkey;
 			};
 		} _sigfault;
 
@@ -142,7 +150,7 @@ typedef struct siginfo {
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
-#define si_pkey		_sifields._sigfault._pkey
+#define si_pkey		_sifields._sigfault._addr_pkey._pkey
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
-- 
2.14.1
