From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 08/14] m68k: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:41 -0400
Message-ID: <20160725034247.109173-9-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46436 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbcGYDnm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:43:42 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/m68k/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 2dcee3a88867..db775322b485 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -42,7 +42,7 @@
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/tracehook.h>
 
 #include <asm/setup.h>
-- 
2.8.4
