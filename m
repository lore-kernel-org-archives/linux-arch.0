Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51515 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755821AbbAFPpm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Jan 2015 10:45:42 -0500
Date: Tue, 6 Jan 2015 17:45:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 36/40] m68k: macro whitespace fixes
Message-ID: <1420558883-10131-37-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Message-ID: <20150106154531.iLRJexvICCkHix9JWM_QUdVp2bWw1fgsXm0Co7lCSOk@z>

While working on arch/m68k/include/asm/uaccess.h, I noticed
that one macro within this header is made harder to read because it
violates a coding style rule: space is missing after comma.

Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/m68k/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/segment.h b/arch/m68k/include/asm/segment.h
index 0fa80e9..98216b8 100644
--- a/arch/m68k/include/asm/segment.h
+++ b/arch/m68k/include/asm/segment.h
@@ -58,7 +58,7 @@ static inline mm_segment_t get_ds(void)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
 #endif
 
-#define segment_eq(a,b)	((a).seg == (b).seg)
+#define segment_eq(a, b) ((a).seg == (b).seg)
 
 #endif /* __ASSEMBLY__ */
 
-- 
MST

