Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262629AbUKEIw6@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:34962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262545AbUKEIw6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2004 03:52:58 -0500
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iA58qv906702
	for <linux-arch@vger.kernel.org>; Fri, 5 Nov 2004 00:52:57 -0800
Date: Fri, 5 Nov 2004 00:52:57 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Fw: 2.6.10-rc1-mm3
Message-Id: <20041105005257.2dc4408e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Guys, just a heads up on the 4-level pagetable stuff.  If you haven't yet
checked it out, please do so.

That reminds me, I need to do a does-it-bloat-the-kernel check...



Begin forwarded message:

Date: Fri, 5 Nov 2004 00:13:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm3



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/


- Added Andi's 4-level-pagetable patches.  It's tested on x86, x86_64, ia64
  and ppc64.  These are fairly intrusive patches and I'll probably push them
  upstream soon.

...

+4level-architecture-changes-for-alpha.patch
+4level-architecture-changes-for-arm.patch
+4level-core-patch.patch
+4level-architecture-changes-for-cris.patch
+4level-convert-drm-to-4levels.patch
+4level-add-asm-generic-support-for-emulating.patch
+4level-ia64-support.patch
+4level-architecture-changes-for-i386.patch
+4level-architecture-changes-for-m32r.patch
+4level-architecture-changes-for-ppc.patch
+4level-architecture-changes-for-ppc64.patch
+4level-architecture-changes-for-s390.patch
+4level-architecture-changes-for-sh.patch
+4level-architecture-changes-for-sh64.patch
+4level-architecture-changes-for-sparc.patch
+4level-architecture-changes-for-sparc64.patch
+4level-architecture-changes-for-x86_64.patch

 4-level pagetables
