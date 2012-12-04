From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/4] x86: enable ARCH_USE_BUILTIN_BSWAP
Date: Tue,  4 Dec 2012 10:15:29 +0000
Message-ID: <1354616130-21587-4-git-send-email-dwmw2@infradead.org>
References: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:43793
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144Ab2LDKPo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Dec 2012 05:15:44 -0500
In-Reply-To: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: David Woodhouse <David.Woodhouse@intel.com>

With -mmovbe enabled (implicit with -march=atom), this allows the
compiler to use the movbe instruction. This doesn't have a significant
effect on code size (unlike on PowerPC), because the movbe instruction
actually takes as many bytes to encode as a simple mov and a bswap. But
for Atom in particular I believe it should give a performance win over
the mov+bswap alternative. That was kind of why movbe was invented in
the first place, after all...

I've done basic functionality testing with IPv6 and Legacy IP, but no
performance testing. The EFI firmware on my test box unfortunately no
longer starts up.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 46c3bff..238f2ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -194,6 +194,9 @@ config ARCH_HAS_CACHE_LINE_SIZE
 config ARCH_HAS_CPU_AUTOPROBE
 	def_bool y
 
+config ARCH_USE_BUILTIN_BSWAP
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
-- 
1.8.0
