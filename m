Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269884AbUH0BOY@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:61115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269878AbUH0BIH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2004 21:08:07 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7R187S0003293
	for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2004 21:08:07 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7R187316141
	for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2004 21:08:07 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.10) with SMTP id i7R182Ps027751
	for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2004 21:08:03 -0400
Date: Thu, 26 Aug 2004 18:08:02 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: bug in syscal arg sign extension
Message-Id: <20040826180802.4f1e6dbb.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Remember this topic long ago?

Anyways, there was a bug in my sparc64 code and it causes all
kinds of trouble for logging daemons.  I was sign extending
the buffer pointer arg instead of the length arg to sys_syslog()
Ooops!
 :-)

Fix attached in cases anyone was doing work for the platform
based upon my sparc64 stuff.

===== arch/sparc64/kernel/sys32.S 1.9 vs edited =====
--- 1.9/arch/sparc64/kernel/sys32.S	2004-06-03 14:51:21 -07:00
+++ edited/arch/sparc64/kernel/sys32.S	2004-08-26 17:49:39 -07:00
@@ -120,7 +120,7 @@
 SIGN2(sys32_setpgid, sys_setpgid, %o0, %o1)
 SIGN3(sys32_setpriority, sys_setpriority, %o0, %o1, %o2)
 SIGN1(sys32_ssetmask, sys_ssetmask, %o0)
-SIGN2(sys32_syslog, sys_syslog, %o0, %o1)
+SIGN2(sys32_syslog, sys_syslog, %o0, %o2)
 SIGN1(sys32_umask, sys_umask, %o0)
 SIGN3(sys32_tgkill, sys_tgkill, %o0, %o1, %o2)
 SIGN1(sys32_sendto, sys_sendto, %o0)
