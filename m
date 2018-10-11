Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45731 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeJKLuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 07:50:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so3538476plr.12
        for <linux-arch@vger.kernel.org>; Wed, 10 Oct 2018 21:25:31 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 1/7] ia64: add __NR_old_getpagesize in uapi/asm/unistd.h
Date: Thu, 11 Oct 2018 09:54:49 +0530
Message-ID: <1539231895-4118-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181011042449.f23FXlxL2UmXeA0kn9D4qhlnd2g54UusRsxiEVSYfcM@z>

sys_getpagesize entry is present in entry.S file to support
for old user interface. So we need to add an uapi entry too.

Add __NR_old_getpagesize in order to not break old user space
as it is reserved for backwards compatibility with old __NR_
getpagesize.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 5fe71d4..4d590c9 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -161,7 +161,7 @@
 #define __NR_nanosleep			1168
 #define __NR_nfsservctl			1169
 #define __NR_prctl			1170
-/* 1171 is reserved for backwards compatibility with old __NR_getpagesize */
+#define __NR_old_getpagesize            1171
 #define __NR_mmap2			1172
 #define __NR_pciconfig_read		1173
 #define __NR_pciconfig_write		1174
-- 
1.9.1
