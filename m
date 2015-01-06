From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 10/40] microblaze/uaccess: fix sparse errors
Date: Tue, 6 Jan 2015 17:44:02 +0200
Message-ID: <1420558883-10131-11-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690AbbAFPoQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Jan 2015 10:44:16 -0500
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Chen Gang <gang.chen.5i5j@gmail.com>

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/microblaze/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index 59a89a6..e41bebf 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -220,7 +220,7 @@ extern long __user_bad(void);
 	} else {							\
 		__gu_err = -EFAULT;					\
 	}								\
-	x = (typeof(*(ptr)))__gu_val;					\
+	x = (__force typeof(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
 
@@ -242,7 +242,7 @@ extern long __user_bad(void);
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\
-	x = (__typeof__(*(ptr))) __gu_val;				\
+	x = (__force __typeof__(*(ptr))) __gu_val;			\
 	__gu_err;							\
 })
 
-- 
MST
