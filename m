Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:6826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264375AbUFCVyF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2004 17:54:05 -0400
Date: Thu, 3 Jun 2004 14:52:24 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: sys_futex() new arg
Message-Id: <20040603145224.3ba55599.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de
List-ID: <linux-arch.vger.kernel.org>


Making sure everyone caught this:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/03 14:51:40-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: New 6th arg of sys_futex needs sign extension.
# 
# arch/sparc64/kernel/sys32.S
#   2004/06/03 14:51:21-07:00 davem@nuts.davemloft.net +1 -1
#   [SPARC64]: New 6th arg of sys_futex needs sign extension.
# 
diff -Nru a/arch/sparc64/kernel/sys32.S b/arch/sparc64/kernel/sys32.S
--- a/arch/sparc64/kernel/sys32.S	2004-06-03 14:52:03 -07:00
+++ b/arch/sparc64/kernel/sys32.S	2004-06-03 14:52:03 -07:00
@@ -91,7 +91,7 @@
 SIGN1(sys32_mq_open, compat_sys_mq_open, %o1)
 SIGN1(sys32_select, compat_sys_select, %o0)
 SIGN1(sys32_mkdir, sys_mkdir, %o1)
-SIGN2(sys32_futex, compat_sys_futex, %o1, %o2)
+SIGN3(sys32_futex, compat_sys_futex, %o1, %o2, %o5)
 SIGN1(sys32_sysfs, compat_sys_sysfs, %o0)
 SIGN3(sys32_ipc, compat_sys_ipc, %o1, %o2, %o3)
 SIGN2(sys32_sendfile, compat_sys_sendfile, %o0, %o1)
