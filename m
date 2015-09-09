Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33105 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbIIVIy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:54 -0400
Received: by pacex6 with SMTP id ex6so20877048pac.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:53 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 08/13] Hide MAX_SHARED_LIBS behind #ifdef __KERNEL__
Date: Wed,  9 Sep 2015 14:08:17 -0700
Message-ID: <1441832902-28993-9-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210817.dKhPBmxZGWABGl5kvneeeaVQKUyB5A4O0XsVMUPZB_U@z>

I'm not sure what this is, but it doesn't feel like something that
should be exposed to userspace here.  I'm assuming this file was
exposed for the structure in it, which doesn't depend on
MAX_SHARED_LIBS.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/flat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/flat.h b/include/uapi/linux/flat.h
index 88cd6baba8f3..4ed679f3591e 100644
--- a/include/uapi/linux/flat.h
+++ b/include/uapi/linux/flat.h
@@ -13,11 +13,13 @@
 
 #define	FLAT_VERSION			0x00000004L
 
+#ifdef __KERNEL__
 #ifdef CONFIG_BINFMT_SHARED_FLAT
 #define	MAX_SHARED_LIBS			(4)
 #else
 #define	MAX_SHARED_LIBS			(1)
 #endif
+#endif /*__KERNEL__*/
 
 /*
  * To make everything easier to port and manage cross platform
-- 
2.4.6

