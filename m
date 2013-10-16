From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 02/17] xtensa: fix build warning in 64-bit build environment
Date: Thu, 17 Oct 2013 02:42:13 +0400
Message-ID: <1381963348-29448-3-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52864 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab3JPWmt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:49 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so1220141lbi.32
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:48 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

This fixes the following build warnings:

arch/xtensa/mm/misc.S: Assembler messages:
arch/xtensa/mm/misc.S:143: Warning: value 0xffffffff30000106 truncated to 0x30000106
arch/xtensa/mm/misc.S:197: Warning: value 0xffffffff30000106 truncated to 0x30000106

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/misc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/mm/misc.S b/arch/xtensa/mm/misc.S
index d97ed1b..1f68558 100644
--- a/arch/xtensa/mm/misc.S
+++ b/arch/xtensa/mm/misc.S
@@ -140,7 +140,7 @@ ENTRY(clear_user_page)
 
 	/* Setup a temporary DTLB with the color of the VPN */
 
-	movi	a4, -PAGE_OFFSET + (PAGE_KERNEL | _PAGE_HW_WRITE)
+	movi	a4, ((PAGE_KERNEL | _PAGE_HW_WRITE) - PAGE_OFFSET) & 0xffffffff
 	movi	a5, TLBTEMP_BASE_1			# virt
 	add	a6, a2, a4				# ppn
 	add	a2, a5, a3				# add 'color'
@@ -194,7 +194,7 @@ ENTRY(copy_user_page)
 	or	a9, a9, a8
 	slli	a4, a4, PAGE_SHIFT
 	s32i	a9, a5, PAGE_FLAGS
-	movi	a5, -PAGE_OFFSET + (PAGE_KERNEL | _PAGE_HW_WRITE)
+	movi	a5, ((PAGE_KERNEL | _PAGE_HW_WRITE) - PAGE_OFFSET) & 0xffffffff
 
 	beqz	a6, 1f
 
-- 
1.8.1.4
