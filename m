From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 18/18] m68k/uaccess: fix sparse errors
Date: Sun, 14 Dec 2014 18:53:14 +0200
Message-ID: <1418575877-21488-19-git-send-email-mst@redhat.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418575877-21488-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/m68k/include/asm/uaccess_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
index 15901db..c31f53f 100644
--- a/arch/m68k/include/asm/uaccess_mm.h
+++ b/arch/m68k/include/asm/uaccess_mm.h
@@ -146,7 +146,7 @@ asm volatile ("\n"					\
 		"	.previous"				\
 		: "+d" (res), "=&" #reg (__gu_val)		\
 		: "m" (*(ptr)), "i" (err));			\
-	(x) = (typeof(*(ptr)))(unsigned long)__gu_val;		\
+	(x) = (__force typeof(*(ptr)))(__force unsigned long)__gu_val;		\
 })
 
 #define __get_user(x, ptr)						\
@@ -188,7 +188,7 @@ asm volatile ("\n"					\
 			  "+a" (__gu_ptr)				\
 			: "i" (-EFAULT)					\
 			: "memory");					\
-		(x) = (typeof(*(ptr)))__gu_val;				\
+		(x) = (__force typeof(*(ptr)))__gu_val;				\
 		break;							\
 	    }	*/							\
 	default:							\
-- 
MST
