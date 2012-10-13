From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 09/25] hexagon: Use Kbuild infrastructure for kvm_para.h
Date: Fri, 12 Oct 2012 22:26:41 -0400
Message-ID: <20121013022953.728743476@goodmis.org>
References: <20121013022632.024527228@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-hexagon-Use-Kbuild-infrastructure-for-kvm_para.h.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Kuo <rkuo@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

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
