From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/6] openrisc: remove unnecessary includes
Date: Tue,  8 May 2012 11:54:01 +0200
Message-ID: <1336470845-13859-3-git-send-email-jonas@southpole.se>
References: <1336470845-13859-1-git-send-email-jonas@southpole.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336470845-13859-1-git-send-email-jonas@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>
List-Id: linux-arch.vger.kernel.org


Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 arch/openrisc/kernel/irq.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 15c5ea3..e935b9d 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -14,15 +14,11 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <linux/ptrace.h>
-#include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/ftrace.h>
 #include <linux/irq.h>
-#include <linux/seq_file.h>
-#include <linux/kernel_stat.h>
 #include <linux/export.h>
 #include <linux/irqdomain.h>
 #include <linux/irqflags.h>
-- 
1.7.0.4
