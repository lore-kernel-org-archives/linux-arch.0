From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 5/5] parisc: add __IGNORE* entries in asm/unistd.h
Date: Thu, 27 Sep 2018 19:54:27 +0530
Message-ID: <1538058267-3765-6-git-send-email-firoz.khan@linaro.org>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

Add __IGNORE* entries for nfsservctl, io_pgetevents and rseq
in the file asm/unistd.h as it is correct to keep __IGNORE*
entry in non uapi header asm/unistd.h while uapi/asm/unistd.h
must hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..9294e10 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -13,6 +13,9 @@
 #define __IGNORE_pkey_mprotect
 #define __IGNORE_pkey_alloc
 #define __IGNORE_pkey_free
+#define __IGNORE_nfsservctl
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
 
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
-- 
1.9.1
