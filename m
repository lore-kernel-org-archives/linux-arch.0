Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18663 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2JMC3z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:29:55 -0400
Message-ID: <20121013022953.728743476@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 09/25] hexagon: Use Kbuild infrastructure for kvm_para.h
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0009-hexagon-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Kuo <rkuo@codeaurora.org>
Message-ID: <20121013022641.AdWjequ6aKjgn4hMj1wSIWINGkFuyyvGyBTqYtwsG9w@z>

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

Cc: linux-kbuild@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/hexagon/include/asm/Kbuild     |    1 +
 arch/hexagon/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/hexagon/include/asm/kvm_para.h

diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 3364b696..616544f 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -26,6 +26,7 @@ generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
+generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += local.h
 generic-y += local.h
diff --git a/arch/hexagon/include/asm/kvm_para.h b/arch/hexagon/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/hexagon/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4


