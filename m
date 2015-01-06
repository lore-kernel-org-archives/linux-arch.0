Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707AbbAFPoS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Jan 2015 10:44:18 -0500
Date: Tue, 6 Jan 2015 17:43:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 03/40] arm64/uaccess: fix sparse errors
Message-ID: <1420558883-10131-4-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Covington <cov@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20150106154340.m4Rcs1tOU4kj79nt8sb6REHo7NwfSHVhNc4XP4EzVXU@z>

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3bf8f4e..9a2069b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -147,7 +147,7 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
 #define __get_user(x, ptr)						\
-- 
MST

