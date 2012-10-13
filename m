Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20543 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab2JMCaB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:30:01 -0400
Message-ID: <20121013022955.738395112@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 23/25] unicore32: Use Kbuild infrastructure for kvm_para.h
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0023-unicore32-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20121013022655.j4rdx4_JDxaoK5p_IBhaJ5noelFQT7_6X7PktPAC_aY@z>

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

Cc: linux-kbuild@vger.kernel.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/unicore32/include/asm/Kbuild     |    1 +
 arch/unicore32/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/unicore32/include/asm/kvm_para.h

diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index c910c98..15b47f2 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mman.h
 generic-y += module.h
diff --git a/arch/unicore32/include/asm/kvm_para.h b/arch/unicore32/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/unicore32/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4


