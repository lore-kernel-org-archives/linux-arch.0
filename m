Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:60956 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbcGYDoM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 24 Jul 2016 23:44:12 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 12/14] parisc: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:45 -0400
Message-ID: <20160725034247.109173-13-paul.gortmaker@windriver.com>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Message-ID: <20160725034245.2wdJlzGoEUM_fD6TzvPZQUE1-3uUPgfEJ5cWmp6-QBs@z>

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

