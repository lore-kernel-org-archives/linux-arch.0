Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37990 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbeJATQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 15:16:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so9400955pgr.5
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 05:39:05 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 5/5] m68k: add __IGNORE* entries in asm/unistd.h
Date: Mon,  1 Oct 2018 18:07:57 +0530
Message-ID: <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181001123757.5uupgiNqDk1BiWMJPFcfBArKkhHgmnGs1kcOdE7KEzE@z>

Add __IGNORE* entries for seccomp, pkey_mprotect, pkey_
alloc, pkey_free, io_pgetevents and rseq in the file
asm/unistd.h as it is correct to keep __IGNORE* entry in
non uapi header asm/unistd.h while uapi/asm/unistd.h must
hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 5072e94..cc5f640 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -31,4 +31,11 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
+#define __IGNORE_seccomp
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
+
 #endif /* _ASM_M68K_UNISTD_H_ */
-- 
1.9.1
