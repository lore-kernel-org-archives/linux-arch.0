From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 21/40] sh: fix put_user sparse errors
Date: Tue, 6 Jan 2015 17:44:41 +0200
Message-ID: <1420558883-10131-22-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

virtio wants to write bitwise types to userspace using put_user.
At the moment this triggers sparse errors, since the value is passed
through an integer.

For example:

	__le32 __user *p;
	__le32 x;
	put_user(x, p);

is safe, but currently triggers a sparse warning.

Fix that up using __force.

Note: this does not suppress any useful sparse checks since caller
assigns x to typeof(*p), which in turn forces all the necessary type
checks.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/uaccess_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/uaccess_64.h b/arch/sh/include/asm/uaccess_64.h
index 2e07e0f..c01376c 100644
--- a/arch/sh/include/asm/uaccess_64.h
+++ b/arch/sh/include/asm/uaccess_64.h
@@ -59,19 +59,19 @@ do {								\
 	switch (size) {						\
 	case 1:							\
 		retval = __put_user_asm_b((void *)&x,		\
-					  (long)ptr);		\
+					  (__force long)ptr);	\
 		break;						\
 	case 2:							\
 		retval = __put_user_asm_w((void *)&x,		\
-					  (long)ptr);		\
+					  (__force long)ptr);	\
 		break;						\
 	case 4:							\
 		retval = __put_user_asm_l((void *)&x,		\
-					  (long)ptr);		\
+					  (__force long)ptr);	\
 		break;						\
 	case 8:							\
 		retval = __put_user_asm_q((void *)&x,		\
-					  (long)ptr);		\
+					  (__force long)ptr);	\
 		break;						\
 	default:						\
 		__put_user_unknown();				\
-- 
MST
