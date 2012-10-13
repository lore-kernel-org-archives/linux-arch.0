Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24822 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2JMC3z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:29:55 -0400
Message-ID: <20121013022953.015897288@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 04/25] blackfin: Use Kbuild infrastructure for kvm_para.h
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0004-blackfin-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>
Message-ID: <20121013022636.XKuu3OBBmW0u0ghx5KARmpcQj-LM5TrQxCCeG8LeyCU@z>

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

Cc: linux-kbuild@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org
Cc: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/blackfin/include/asm/Kbuild     |    1 +
 arch/blackfin/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/blackfin/include/asm/kvm_para.h

diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 5a0625a..731b81a 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
+generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += local.h
 generic-y += mman.h
diff --git a/arch/blackfin/include/asm/kvm_para.h b/arch/blackfin/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/blackfin/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4


