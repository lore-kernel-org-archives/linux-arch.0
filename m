From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 39/73] powerpc: delete another unrequired instance of <linux/init.h>
Date: Tue, 21 Jan 2014 16:22:42 -0500
Message-ID: <1390339396-3479-40-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Most were already deleted in the 1st pass audit; this instance
showed up more recently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/sysdev/indirect_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 1f6c570..66f5fd1 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -13,7 +13,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/string.h>
-#include <linux/init.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
-- 
1.8.4.1
