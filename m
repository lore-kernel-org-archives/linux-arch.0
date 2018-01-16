From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 16/22] signal/frv: Move the frv specific si_codes to asm-generic/siginfo.h
Date: Mon, 15 Jan 2018 18:40:03 -0600
Message-ID: <20180116004009.31036-16-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46793 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeAPAnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:43:37 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Having si_codes in many different files simply encourages duplicate definitions
that can cause problems later.  To avoid that merce the frv specific si_codes
into uapi/asm-generic/siginfo.h

This allows the removal of arch/frv/uapi/include/asm/siginfo.h as the last
last meaningful definition it held was FPE_MDAOVF.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/frv/include/uapi/asm/Kbuild    |  1 +
 arch/frv/include/uapi/asm/siginfo.h | 13 -------------
 include/uapi/asm-generic/siginfo.h  |  3 +++
 3 files changed, 4 insertions(+), 13 deletions(-)
 delete mode 100644 arch/frv/include/uapi/asm/siginfo.h

diff --git a/arch/frv/include/uapi/asm/Kbuild b/arch/frv/include/uapi/asm/Kbuild
index 14a2e9af97e9..5354b0f84d41 100644
--- a/arch/frv/include/uapi/asm/Kbuild
+++ b/arch/frv/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += siginfo.h
 generic-y += bpf_perf_event.h
diff --git a/arch/frv/include/uapi/asm/siginfo.h b/arch/frv/include/uapi/asm/siginfo.h
deleted file mode 100644
index 4c8c975747ac..000000000000
--- a/arch/frv/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_SIGINFO_H
-#define _ASM_SIGINFO_H
-
-#include <linux/types.h>
-#include <asm-generic/siginfo.h>
-
-#define FPE_MDAOVF	9	/* media overflow */
-#undef NSIGFPE
-#define NSIGFPE		9
-
-#endif
-
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 2f0ae4607603..f1c0af4f36a4 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -204,6 +204,9 @@ typedef struct siginfo {
 #define FPE_FLTRES	6	/* floating point inexact result */
 #define FPE_FLTINV	7	/* floating point invalid operation */
 #define FPE_FLTSUB	8	/* subscript out of range */
+#ifdef __frv__
+# define FPE_MDAOVF	9	/* media overflow */
+#endif
 #ifdef __ia64__
 # define __FPE_DECOVF	9	/* decimal overflow */
 # define __FPE_DECDIV	10	/* decimal division by zero */
-- 
2.14.1
