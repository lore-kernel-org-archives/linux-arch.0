Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34668 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdAVQdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:33:43 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 18/20] hexagon: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:42 -0500
Message-ID: <20170122163244.11740-19-paul.gortmaker@windriver.com>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
Message-ID: <20170122163242._kKymgOcoPRJd7-fB4ReYyLhcMYAVzHlRfKuYueGkE0@z>

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

