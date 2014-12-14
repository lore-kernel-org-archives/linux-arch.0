Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbaLNQwu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 14 Dec 2014 11:52:50 -0500
Date: Sun, 14 Dec 2014 18:52:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 10/18] microblaze/uaccess: fix sparse errors
Message-ID: <1418575877-21488-11-git-send-email-mst@redhat.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418575877-21488-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Chen Gang <gang.chen.5i5j@gmail.com>
Message-ID: <20141214165238.lR6j-NQfZ9V50dV8v7oBWG4x5xxkcDhs00pseMXdTXM@z>

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/microblaze/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index 59a89a6..57acf04 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -220,7 +220,7 @@ extern long __user_bad(void);
 	} else {							\
 		__gu_err = -EFAULT;					\
 	}								\
-	x = (typeof(*(ptr)))__gu_val;					\
+	x = (__force typeof(*(ptr)))__gu_val;					\
 	__gu_err;							\
 })
 
@@ -242,7 +242,7 @@ extern long __user_bad(void);
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\
-	x = (__typeof__(*(ptr))) __gu_val;				\
+	x = (__force __typeof__(*(ptr))) __gu_val;				\
 	__gu_err;							\
 })
 
-- 
MST

