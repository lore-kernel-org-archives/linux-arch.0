Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:40157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261691AbUCXIZT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 03:25:19 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i2O8PJWA001736
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 03:25:19 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i2O8PJj27919
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 03:25:19 -0500
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.10/8.12.10) with SMTP id i2O8P11n012307
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 03:25:02 -0500
Date: Wed, 24 Mar 2004 00:25:18 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: sys32_mount bug
Message-Id: <20040324002518.11c9ffae.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Systems using compat system calls will need this too.

We weren't handling a NULL 'type' argument to mount() properly,
f.e. this happens legitimately when changing the options of an
existing mount.

===== arch/sparc64/kernel/sys_sparc32.c 1.91 vs edited =====
--- 1.91/arch/sparc64/kernel/sys_sparc32.c	Fri Mar 12 01:30:19 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Wed Mar 24 00:21:16 2004
@@ -1481,13 +1481,12 @@
 	if (err)
 		goto out;
 
-	if (!type_page) {
-		err = -EINVAL;
-		goto out;
+	if (type_page) {
+		is_smb = !strcmp((char *)type_page, SMBFS_NAME);
+		is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
+	} else {
+		is_smb = is_ncp = 0;
 	}
-
-	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
 
 	err = copy_mount_stuff_to_kernel((const void *)AA(data), &data_page);
 	if (err)
