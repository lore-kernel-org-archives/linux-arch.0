Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753650AbdJaPvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Oct 2017 11:51:41 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v5 05/30] arm64: efi: Add missing Kconfig dependency on KERNEL_MODE_NEON
Date: Tue, 31 Oct 2017 15:50:57 +0000
Message-ID: <1509465082-30427-6-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171031155057.dyZaKtMv3bk-Vbul2uFe0SDNkf2qjktbzuCSmFWQjxs@z>

The EFI runtime services ABI permits calls to EFI to clobber
certain FPSIMD/NEON registers, as per the AArch64 procedure call
standard.

Saving/restoring the clobbered registers around such calls needs
KERNEL_MODE_NEON, but the dependency is missing from Kconfig.

This patch adds the missing dependency.

This will aid bisection of the patches implementing support for the
ARM Scalable Vector Extension (SVE).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05aa592..5cfb79d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1064,6 +1064,7 @@ config EFI_STUB
 config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
+	depends on KERNEL_MODE_NEON
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
-- 
2.1.4
