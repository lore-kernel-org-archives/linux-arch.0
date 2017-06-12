From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 12/27] ia64: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:06 +0900
Message-ID: <1497238041-7011-13-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:63959 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdFLD2H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2017 23:28:07 -0400
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org

"generic-y += kvm_para.h" is doubled in asm/Kbuild and uapi/asm/Kbuild.
The one in the former should be simply removed because kvm_para.h is
exported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/ia64/include/asm/Kbuild | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 502a91d8dbbd..1d7641f891e1 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,8 +1,6 @@
-
 generic-y += clkdev.h
 generic-y += exec.h
 generic-y += irq_work.h
-generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
-- 
2.7.4
