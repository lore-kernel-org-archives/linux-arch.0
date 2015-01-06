From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 28/40] microblaze: whitespace fix
Date: Tue, 6 Jan 2015 17:45:03 +0200
Message-ID: <1420558883-10131-29-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Chen Gang <gang.chen.5i5j@gmail.com>
List-Id: linux-arch.vger.kernel.org

Align using tabs to make code prettier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/microblaze/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index e41bebf..62942fd 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -306,7 +306,7 @@ extern long __user_bad(void);
 
 #define __put_user_check(x, ptr, size)					\
 ({									\
-	typeof(*(ptr)) volatile __pu_val = x;					\
+	typeof(*(ptr)) volatile __pu_val = x;				\
 	typeof(*(ptr)) __user *__pu_addr = (ptr);			\
 	int __pu_err = 0;						\
 									\
-- 
MST
