From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/13] Hide COMPAT_ATM_ADDPARTY behind #ifdef __KERNEL__
Date: Wed,  9 Sep 2015 14:08:12 -0700
Message-ID: <1441832902-28993-4-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34584 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbbIIVIs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:48 -0400
Received: by padhy16 with SMTP id hy16so20834055pad.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:48 -0700 (PDT)
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>

This used to just be behind an #ifdef COMPAT_COMPAT, so most of
userspace wouldn't have seen the definition before.  This change just
makes the __KERNEL__ part explicit to quiet the header checker.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/atmdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
index 93e0ec008ca8..f8b6223165da 100644
--- a/include/uapi/linux/atmdev.h
+++ b/include/uapi/linux/atmdev.h
@@ -100,7 +100,7 @@ struct atm_dev_stats {
 					/* use backend to make new if */
 #define ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct atm_iobuf)
  					/* add party to p2mp call */
-#ifdef CONFIG_COMPAT
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
 #define COMPAT_ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct compat_atm_iobuf)
 #endif
-- 
2.4.6
