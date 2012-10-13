Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:28011 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab2JMCaA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:30:00 -0400
Message-ID: <20121013022954.595178706@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 15/25] openrisc: Use Kbuild infrastructure for kvm_para.h
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0015-openrisc-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonas Bonn <jonas@southpole.se>
Message-ID: <20121013022647.d1CsJw6BIp7StkgYVbVMWXuyQTjEyEHFuJ3vlUNJXA0@z>

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

Cc: linux-kbuild@vger.kernel.org
Cc: linux@lists.openrisc.net
Cc: Jonas Bonn <jonas@southpole.se>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/openrisc/include/asm/Kbuild     |    1 +
 arch/openrisc/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/openrisc/include/asm/kvm_para.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 7140b6b..d715037 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -34,6 +34,7 @@ generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mman.h
 generic-y += module.h
diff --git a/arch/openrisc/include/asm/kvm_para.h b/arch/openrisc/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/openrisc/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4


