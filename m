From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 10/20] openrisc: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:34 -0500
Message-ID: <20170122163244.11740-11-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile these files.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/openrisc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index b1a7435e786a..53592a639744 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -17,7 +17,7 @@
 
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/sched.h>
 
 #include <linux/uaccess.h>
-- 
2.11.0
