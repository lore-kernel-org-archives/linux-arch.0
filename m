Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:37065 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262960AbUCXBVI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 20:21:08 -0500
Date: Wed, 24 Mar 2004 12:17:28 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [meissner@suse.de: getdents patch for 32 -> 64 converter]
Message-ID: <20040324011728.GF27747@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Im guessing this fix will be required on other 64bit archs.

Anton

----- Forwarded message from Marcus Meissner <meissner@suse.de> -----

From: Marcus Meissner <meissner@suse.de>
To: linuxppc64-dev@lists.linuxppc.org
Subject: getdents patch for 32 -> 64 converter

Hi,

With 2.6.4 we now have the glorious hidden d_type passing in
getdents.

glibc CVS expects this to be passed if we have a kernel version after 2.6.4,
so we have to also handle it in the 32bit syscall converter.

The kernel at least bootet here and my testcase (bootstrap gcc)
works fine now.

Can someone please review / apply?

Ciao, Marcus

--- linux/arch/ppc64/kernel/sys_ppc32.c.dtype	2004-03-23 14:10:10.000000000 +0100
+++ linux/arch/ppc64/kernel/sys_ppc32.c	2004-03-23 14:11:02.000000000 +0100
@@ -534,7 +534,7 @@
 {
 	struct linux_dirent32 * dirent;
 	struct getdents_callback32 * buf = (struct getdents_callback32 *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);

 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
@@ -548,6 +548,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
+	put_user(d_type, (char *) dirent + reclen - 1);
 	((char *) dirent) += reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;

** Sent via the linuxppc64-dev mail list. See http://lists.linuxppc.org/

----- End forwarded message -----
