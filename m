Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:5558 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbbHGPWi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:22:38 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 04/11] xtensa: Export __strnlen_user to modules
Date: Fri, 7 Aug 2015 16:21:57 +0100
Message-ID: <1438960924-23628-5-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Message-ID: <20150807152157.C1-SmCLS6O4k4z9vWTxEL4qtAwIaCNMY-izNoSEhFqI@z>

Update the Xtensa architecture code to export __strnlen_user() to
modules, so that modules can make use of strnlen_user() and
strlen_user(). For example the test_user_copy module will soon test
them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/kernel/xtensa_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 4d2872fd9bb5..1a47bb621816 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -42,6 +42,7 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__strncpy_user);
+EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(clear_page);
 EXPORT_SYMBOL(copy_page);
 
-- 
2.3.6

