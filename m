Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36088 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbIIVIt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:49 -0400
Received: by padhk3 with SMTP id hk3so20674252pad.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:49 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
Date: Wed,  9 Sep 2015 14:08:13 -0700
Message-ID: <1441832902-28993-5-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210813.2BT7jQmHNpy1xv9fOoCsQPPSxFhiqLXZnoY_T-t392k@z>

This used to be hidden behind CONFIG_MMAP_ALLOW_UNINITIALIZED, so
userspace wouldn't actually ever see it.  While I could have kept
hiding it, the man pages seem to indicate that MAP_UNINITIALIZED
should be visible:

  mmap(2)
  MAP_UNINITIALIZED (since Linux 2.6.33)
    Don't clear anonymous pages.  This flag is intended to improve
    performance on embedded devices.  This flag is honored only if the
    kernel was configured with the CONFIG_MMAP_ALLOW_UNINITIALIZED
    option.  Because of the security implications, that option is
    normally enabled only on embedded devices (i.e., devices where one
    has complete control of the contents of user memory).

and since the only time it shows up in my /usr/include is in this
header I believe this should have been visible to userspace (as
non-zero, which wouldn't do anything when or'd into the flags) all
along.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/mman-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ddc3b36f1046..e58d1911ecc6 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -19,7 +19,7 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
+#if !defined(__KERNEL__) || defined(CONFIG_MMAP_ALLOW_UNINITIALIZED)
 # define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
 #else
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-- 
2.4.6

