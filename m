From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 34/40] frv: macro whitespace fixes
Date: Tue, 6 Jan 2015 17:45:25 +0200
Message-ID: <1420558883-10131-35-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

While working on arch/frv/include/asm/uaccess.h, I noticed
that one macro within this header is made harder to read because it
violates a coding style rule: space is missing after comma.

Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/frv/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/frv/include/asm/segment.h b/arch/frv/include/asm/segment.h
index a2320a4..4377c89 100644
--- a/arch/frv/include/asm/segment.h
+++ b/arch/frv/include/asm/segment.h
@@ -31,7 +31,7 @@ typedef struct {
 
 #define get_ds()		(KERNEL_DS)
 #define get_fs()		(__current_thread_info->addr_limit)
-#define segment_eq(a,b)		((a).seg == (b).seg)
+#define segment_eq(a, b)	((a).seg == (b).seg)
 #define __kernel_ds_p()		segment_eq(get_fs(), KERNEL_DS)
 #define get_addr_limit()	(get_fs().seg)
 
-- 
MST
