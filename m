Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755793AbbAFPpD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Jan 2015 10:45:03 -0500
Date: Tue, 6 Jan 2015 17:44:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 24/40] avr32: whitespace fix
Message-ID: <1420558883-10131-25-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Message-ID: <20150106154450.d12w0yJ8jnPdDvl9xSpqJj2dTZFv2-UzLtyX5bW2Q9s@z>

Align using tabs to make code prettier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/avr32/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/avr32/include/asm/uaccess.h b/arch/avr32/include/asm/uaccess.h
index ccd07c4..72607f3 100644
--- a/arch/avr32/include/asm/uaccess.h
+++ b/arch/avr32/include/asm/uaccess.h
@@ -278,7 +278,7 @@ extern int __put_user_bad(void);
 				       __pu_err);			\
 			break;						\
 		case 8:							\
-			__put_user_asm("d", __pu_addr, __pu_val,		\
+			__put_user_asm("d", __pu_addr, __pu_val,	\
 				       __pu_err);			\
 			break;						\
 		default:						\
-- 
MST

