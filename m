From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 2/3] c6x: add __ARCH_NOMMU as a bugfix
Date: Mon,  7 Jan 2019 20:22:45 +0530
Message-ID: <1546872766-3354-3-git-send-email-firoz.khan@linaro.org>
References: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-c6x-dev@linux-c6x.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

Add __ARCH_NOMMU in uapi/asm/unistd.h file as a bugfix.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/c6x/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 6b2fe79..9e9ffe5 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_NOMMU
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-- 
1.9.1
