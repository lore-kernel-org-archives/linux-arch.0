Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:56907 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbbHGPWg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:22:36 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 02/11] nios2: Export strncpy_from_user / strnlen_user to modules
Date: Fri, 7 Aug 2015 16:21:55 +0100
Message-ID: <1438960924-23628-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Message-ID: <20150807152155.ULxkMglNJ4Y_ljQ44qm8cawDI1zR8-5OsnSdvv7mCmQ@z>

Update the nios2 architecture code to export strncpy_from_user() and
strnlen_user() to modules. The test_user_copy module will soon test
them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
---
 arch/nios2/mm/uaccess.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/mm/uaccess.c b/arch/nios2/mm/uaccess.c
index 7663e156ff4f..ecd8b122948b 100644
--- a/arch/nios2/mm/uaccess.c
+++ b/arch/nios2/mm/uaccess.c
@@ -146,6 +146,7 @@ long strncpy_from_user(char *__to, const char __user *__from, long __len)
 		l--;
 	return l;
 }
+EXPORT_SYMBOL(strncpy_from_user);
 
 long strnlen_user(const char __user *s, long n)
 {
@@ -161,3 +162,4 @@ long strnlen_user(const char __user *s, long n)
 	}
 	return n + 1;
 }
+EXPORT_SYMBOL(strnlen_user);
-- 
2.3.6

