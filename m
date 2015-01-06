From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 17/40] arm: fix put_user sparse errors
Date: Tue, 6 Jan 2015 17:44:27 +0200
Message-ID: <1420558883-10131-18-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Victor Kamensky <victor.kamensky@linaro.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, =?us-ascii?B?PT9VVEYtOD9xP1V3ZT0yMEtsZWluZS1LPUMzPUI2bmlnPz0=?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
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
 arch/arm/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 4767eb9..74fcde7 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -413,14 +413,14 @@ do {									\
 #ifndef __ARMEB__
 #define __put_user_asm_half(x,__pu_addr,err)			\
 ({								\
-	unsigned long __temp = (unsigned long)(x);		\
+	unsigned long __temp = (__force unsigned long)(x);	\
 	__put_user_asm_byte(__temp, __pu_addr, err);		\
 	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err);	\
 })
 #else
 #define __put_user_asm_half(x,__pu_addr,err)			\
 ({								\
-	unsigned long __temp = (unsigned long)(x);		\
+	unsigned long __temp = (__force unsigned long)(x);	\
 	__put_user_asm_byte(__temp >> 8, __pu_addr, err);	\
 	__put_user_asm_byte(__temp, __pu_addr + 1, err);	\
 })
-- 
MST
