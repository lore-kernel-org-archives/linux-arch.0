From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH repost 05/16] blackfin/uaccess: fix sparse errors
Date: Thu, 25 Dec 2014 11:28:48 +0200
Message-ID: <1419499661-8566-6-git-send-email-mst@redhat.com>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419499661-8566-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Steven Miao <realmz6@gmail.com>
---
 arch/blackfin/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/blackfin/include/asm/uaccess.h b/arch/blackfin/include/asm/uaccess.h
index 57701c3..6a46e7d 100644
--- a/arch/blackfin/include/asm/uaccess.h
+++ b/arch/blackfin/include/asm/uaccess.h
@@ -147,7 +147,7 @@ static inline int bad_user_access_length(void)
 		}						\
 	} else							\
 		_err = -EFAULT;					\
-	x = (typeof(*(ptr)))_val;				\
+	x = (__force typeof(*(ptr)))_val;				\
 	_err;							\
 })
 
-- 
MST
