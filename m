From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 19/20] core: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:43 -0500
Message-ID: <20170122163244.11740-20-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60061 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdAVQeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:34:15 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

These files were including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and where possible, avoid all
the extra header content in module.h that we don't really need to
compile these non-modular files.

Note:
   init/main.c still needs module.h for __init_or_module
   kernel/extable.c still needs module.h for is_module_text_address

...and so we don't get the benefit of removing module.h from the cpp
feed for these two files, unlike the almost universal 1:1 exchange
of module.h for extable.h we were able to do in the arch dirs.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 init/main.c      | 1 +
 kernel/extable.c | 1 +
 kernel/module.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/init/main.c b/init/main.c
index b0c9d6facef9..5b244bc1c176 100644
--- a/init/main.c
+++ b/init/main.c
@@ -12,6 +12,7 @@
 #define DEBUG		/* Enable initcall_debug */
 
 #include <linux/types.h>
+#include <linux/extable.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
diff --git a/kernel/extable.c b/kernel/extable.c
index e3beec4a2339..b25d9901e431 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -17,6 +17,7 @@
 */
 #include <linux/ftrace.h>
 #include <linux/memory.h>
+#include <linux/extable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
diff --git a/kernel/module.c b/kernel/module.c
index 5088784c0cf9..43b6fb20fdf4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -17,6 +17,7 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/export.h>
+#include <linux/extable.h>
 #include <linux/moduleloader.h>
 #include <linux/trace_events.h>
 #include <linux/init.h>
-- 
2.11.0
