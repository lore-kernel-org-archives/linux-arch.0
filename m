From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v5 09/12] vfs,
 fdtable: prevent bounds-check bypass via speculative execution
Date: Fri, 26 Jan 2018 23:56:02 -0800
Message-ID: <151703976200.26578.16181908340589076165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151703971300.26578.1185595719337719486.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4930 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeA0IFI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jan 2018 03:05:08 -0500
In-Reply-To: <151703971300.26578.1185595719337719486.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, gregkh@linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>, torvalds@linux-foundation.org, alan@linux.intel.com

'fd' is a user controlled value that is used as a data dependency to
read from the 'fdt->fd' array.  In order to avoid potential leaks of
kernel memory values, block speculative execution of the instruction
stream that could issue reads based on an invalid 'file *' returned from
__fcheck_files.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fdtable.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 1c65817673db..c61f06c77fdf 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -10,6 +10,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -82,8 +83,10 @@ static inline struct file *__fcheck_files(struct files_struct *files, unsigned i
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_idx(fd, fdt->max_fds);
 		return rcu_dereference_raw(fdt->fd[fd]);
+	}
 	return NULL;
 }
 
