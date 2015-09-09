Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36203 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbbIIVI6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:58 -0400
Received: by padhk3 with SMTP id hk3so20677122pad.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:57 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 11/13] Hide MAX_RAW_MINORS behind #ifdef __KERNEL__
Date: Wed,  9 Sep 2015 14:08:20 -0700
Message-ID: <1441832902-28993-12-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210820.shDB_veiJnvbIfPjHU7ep_PEBuWJxK4wzFzD65dQFBQ@z>

I don't think this was ever meant to be exposed to userspace.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/raw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/raw.h b/include/uapi/linux/raw.h
index 62d543e70603..6d8d87524ff2 100644
--- a/include/uapi/linux/raw.h
+++ b/include/uapi/linux/raw.h
@@ -13,6 +13,8 @@ struct raw_config_request
 	__u64	block_minor;
 };
 
+#ifdef __KERNEL__
 #define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
+#endif
 
 #endif /* __LINUX_RAW_H */
-- 
2.4.6

