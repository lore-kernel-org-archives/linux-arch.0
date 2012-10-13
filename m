From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 02/25] arm: Use Kbuild infrastructure to handle asm-generic headers
Date: Fri, 12 Oct 2012 22:26:34 -0400
Message-ID: <20121013022952.704673488@goodmis.org>
References: <20121013022632.024527228@goodmis.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:28011 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2JMC3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:29:54 -0400
Content-Disposition: inline; filename=0002-arm-Use-Kbuild-infrastructure-to-handle-asm-generic-.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>

From: Steven Rostedt <srostedt@redhat.com>

Use Kbuild infrastructure to handle the asm-generic headers
and remove the wrapper headers that call them.

This only affects headers that do nothing but include the generic
equivalent. It does not touch any header that does a little more.

Cc: linux-kbuild@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/include/asm/Kbuild     |    2 ++
 arch/arm/include/asm/kvm_para.h |    1 -
 arch/avr32/include/asm/ipcbuf.h |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_para.h
 delete mode 100644 arch/avr32/include/asm/ipcbuf.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 8a7196c..ad80160 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += ioctl.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += msgbuf.h
@@ -35,3 +36,4 @@ generic-y += termios.h
 generic-y += timex.h
 generic-y += types.h
 generic-y += unaligned.h
+generic-y += ipcbuf.h
diff --git a/arch/arm/include/asm/kvm_para.h b/arch/arm/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/arm/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
diff --git a/arch/avr32/include/asm/ipcbuf.h b/arch/avr32/include/asm/ipcbuf.h
deleted file mode 100644
index 84c7e51..0000000
--- a/arch/avr32/include/asm/ipcbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipcbuf.h>
-- 
1.7.10.4
