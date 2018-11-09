Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeKIWTH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:19:07 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 22/27] arm64: Enable compat vDSO support
Date: Fri,  9 Nov 2018 12:37:25 +0000
Message-ID: <20181109123730.8743-23-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123725.9YGOPqTKGZHHmnsaYZ-VNMSlJnsl_PaqMJBM-2OLS9M@z>

This patch enables compat vDSO support in the arm64 defconfig.

Note that the default compiler is set to arm-linux-gnueabihf-.
For this to take effect and for the compat vDSO to compile correctly, it
is required that this compiler is in the PATH.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..cfd5d67c6407 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -709,6 +709,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
+CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
-- 
2.19.1
