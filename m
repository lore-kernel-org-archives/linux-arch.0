Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10985 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2JMC37 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:29:59 -0400
Message-ID: <20121013022955.610890388@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 22/25] um: Use Kbuild infrastructure for kvm_para.h
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0022-um-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Message-ID: <20121013022654.N4AyjZ721buKGjQqXPZ-of_bdTwHFdYonDJtfPpMce0@z>

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

(also had to add ipcbuf.h)

Cc: linux-kbuild@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/um/include/asm/Kbuild     |    2 +-
 arch/um/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
 delete mode 100644 arch/um/include/asm/kvm_para.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 0f6e7b3..ad316e7 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,4 +1,4 @@
 generic-y += bug.h cputime.h device.h emergency-restart.h futex.h hardirq.h
 generic-y += hw_irq.h irq_regs.h kdebug.h percpu.h sections.h topology.h xor.h
 generic-y += ftrace.h pci.h io.h param.h delay.h mutex.h current.h exec.h
-generic-y += switch_to.h clkdev.h
+generic-y += switch_to.h clkdev.h kvm_para.h ipcbuf.h
diff --git a/arch/um/include/asm/kvm_para.h b/arch/um/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/um/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4


