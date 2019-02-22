Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfBVM0b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:26:31 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 19/23] arm64: Enable compat vDSO support
Date: Fri, 22 Feb 2019 12:24:26 +0000
Message-ID: <20190222122430.21180-20-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122426.0EkWQ29NgJ9r2Nt6z2jRrfmFXpCucYIzmu5VWYMjS58@z>

Enable compat vDSO support in the arm64 defconfig.

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
index c8432e24207e..3adebe5f3573 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -120,6 +120,7 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
+CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
 CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
-- 
2.20.1
