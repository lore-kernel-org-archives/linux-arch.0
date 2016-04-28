From: Christopher Covington <cov@codeaurora.org>
Subject: [RFC 5/5] arm64: Gain VDSO unmap and remap powers
Date: Thu, 28 Apr 2016 11:18:57 -0400
Message-ID: <1461856737-17071-6-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Christopher Covington <cov@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

Checkpoint/Restore In Userspace (CRIU) must be able to remap and unmap the
Virtual Dynamic Shared Object (VDSO) to be able to handle the changing
addresses that result from address space layout randomization. Now that the
support for this originally written for PowerPC has been moved to a generic
location and arm64 has adopted unsigned long for the type of mm->context.vdso,
simply opt-in to VDSO unmap and remap support.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..cbdce39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VDSO_MAP
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
