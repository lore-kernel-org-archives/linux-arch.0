From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 06/10] mn10300: migrate exception table users off module.h and onto extable.h
Date: Mon, 9 Jan 2017 15:40:06 -0500
Message-ID: <20170109204010.5047-7-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:44042 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936920AbdAIUlL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Jan 2017 15:41:11 -0500
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: David Howells <dhowells@redhat.com>
Cc: linux-am33-list@redhat.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mn10300/mm/extable.c      | 2 +-
 arch/mn10300/mm/misalignment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mn10300/mm/extable.c b/arch/mn10300/mm/extable.c
index 305de461cb8f..045a903ee6b9 100644
--- a/arch/mn10300/mm/extable.c
+++ b/arch/mn10300/mm/extable.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the Licence, or (at your option) any later version.
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
diff --git a/arch/mn10300/mm/misalignment.c b/arch/mn10300/mm/misalignment.c
index 31d04da85743..b39a388825ae 100644
--- a/arch/mn10300/mm/misalignment.c
+++ b/arch/mn10300/mm/misalignment.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the Licence, or (at your option) any later version.
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-- 
2.11.0
