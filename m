From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/4] powerpc: enable ARCH_USE_BUILTIN_BSWAP
Date: Tue,  4 Dec 2012 10:15:28 +0000
Message-ID: <1354616130-21587-3-git-send-email-dwmw2@infradead.org>
References: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:43808
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab2LDKPr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Dec 2012 05:15:47 -0500
In-Reply-To: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: David Woodhouse <David.Woodhouse@intel.com>

By using the compiler intrinsics instead of hand-crafted opaque inline
assembler for byte-swapping, we let the compiler see what's actually
happening and it gets to use lwbrx/stwbrx instructions instead of a
normal load/store coupled with a sequence of rlwimi instructions to
move bits around.

Compiled-tested only. It gave a code size reduction of almost 4% for
ext2, and more like 2.5% for ext3/ext4.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/powerpc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a902a5c..b4ea516 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -78,6 +78,9 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default y if 64BIT
 
+config ARCH_USE_BUILTIN_BSWAP
+       def_bool y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
-- 
1.8.0
