From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 21/25] tile: Use Kbuild infrastructure for kvm_para.h
Date: Fri, 12 Oct 2012 22:26:53 -0400
Message-ID: <20121013022955.456205573@goodmis.org>
References: <20121013022632.024527228@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0021-tile-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: linux-arch.vger.kernel.org

From: Steven Rostedt <srostedt@redhat.com>

All the headers but kvm_para.h use the Kbuild infrastructure to
get to the asm-generic headers.

Cc: linux-kbuild@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/tile/include/asm/Kbuild     |    1 +
 arch/tile/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/tile/include/asm/kvm_para.h

diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 5cd98fa..0296734 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += ioctls.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += msgbuf.h
 generic-y += mutex.h
diff --git a/arch/tile/include/asm/kvm_para.h b/arch/tile/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/tile/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.4
