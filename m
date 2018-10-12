Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34501 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeJLRQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 13:16:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so5608228pgs.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 02:45:12 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v4 6/6] parisc: syscalls: Ignore nfsservctl for other architectures
Date: Fri, 12 Oct 2018 15:14:02 +0530
Message-ID: <1539337442-3676-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181012094402.fB0kU2CbYIhkBvEiKN1u-tG2zPBEozhsN-FwVI_Wm54@z>

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1
