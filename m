Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:45694 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdGISdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 14:33:17 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 12/28] ia64: remove redundant generic-y += kvm_para.h from asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:44 +0900
Message-ID: <1499625180-8067-13-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20170709183244.cFgIrR4PmLt2vQO31rD4KvX69e3gY4FVNlho1fWYHlk@z>

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
