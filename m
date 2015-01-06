From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 01/40] x86/uaccess: fix sparse errors
Date: Tue, 6 Jan 2015 17:43:30 +0200
Message-ID: <1420558883-10131-2-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 0d592e0..ace9dec 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -179,7 +179,7 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 	asm volatile("call __get_user_%P3"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu)			\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
-	(x) = (__typeof__(*(ptr))) __val_gu;				\
+	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
 	__ret_gu;							\
 })
 
-- 
MST
