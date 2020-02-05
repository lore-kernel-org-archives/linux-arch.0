From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 26/26] um: fix clone flags to be familar with valgrind
Date: Wed,  5 Feb 2020 16:30:35 +0900
Message-ID: <b3072caaef01f2cef5f34bc012e066826798500c.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54158 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBEHbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so601107pjc.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:47 -0800 (PST)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

Valgrind reports the following error with UML when ubd driver is
compiled in.

==29588== Unsupported clone() flags: 0x500
==29588==
==29588== The only supported clone() uses are:
==29588==  - via a threads library (LinuxThreads or NPTL)
==29588==  - via the implementation of fork or vfork

Adding CLONE_FS flags silences this issue.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/ubd_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..fabb50e91c37 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -47,7 +47,8 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}
 
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
+	pid = clone(io_thread, (void *) sp,
+		    CLONE_FILES | CLONE_VM | CLONE_FS, NULL);
 	if(pid < 0){
 		err = -errno;
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
-- 
2.21.0 (Apple Git-122.2)
