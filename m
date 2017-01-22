From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 18/20] hexagon: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:42 -0500
Message-ID: <20170122163244.11740-19-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-hexagon-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/hexagon/mm/vm_fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index de863d6d802b..489875fd2be4 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -29,7 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm.h>
 #include <linux/signal.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/hardirq.h>
 
 /*
-- 
2.11.0
