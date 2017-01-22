From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 14/20] metag: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:38 -0500
Message-ID: <20170122163244.11740-15-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:58902 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751721AbdAVQdk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 22 Jan 2017 11:33:40 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, James Hogan <james.hogan@imgtec.com>

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/metag/mm/extable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/metag/mm/extable.c b/arch/metag/mm/extable.c
index 2a21eaebe84d..3aa90b78b43d 100644
--- a/arch/metag/mm/extable.c
+++ b/arch/metag/mm/extable.c
@@ -1,5 +1,4 @@
-
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
-- 
2.11.0
