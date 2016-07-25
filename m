From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 12/14] parisc: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:45 -0400
Message-ID: <20160725034247.109173-13-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/parisc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 163af2c31d76..a67519b79504 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -14,7 +14,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 #include <asm/traps.h>
-- 
2.8.4
