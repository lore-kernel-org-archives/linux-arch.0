Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32895 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeJHM1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Oct 2018 08:27:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so7292333pge.0
        for <linux-arch@vger.kernel.org>; Sun, 07 Oct 2018 22:17:48 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 6/6] parisc: syscalls: Ignore nfsservctl for other architectures
Date: Mon,  8 Oct 2018 10:46:41 +0530
Message-ID: <1538975801-13735-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181008051641.kn7_tBSZLgIS0bfxhnFzP7eCgOwd8QUBgphWX7QKchw@z>

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
