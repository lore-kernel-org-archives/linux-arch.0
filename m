From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 06/17] xtensa: enable HAVE_IRQ_TIME_ACCOUNTING
Date: Thu, 17 Oct 2013 02:42:17 +0400
Message-ID: <1381963348-29448-7-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63825 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab3JPWm4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:56 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so1196968lbi.39
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:54 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8d24dcb..fb140ae 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -19,6 +19,7 @@ config XTENSA
 	select IRQ_DOMAIN
 	select HAVE_OPROFILE
 	select HAVE_FUNCTION_TRACER
+	select HAVE_IRQ_TIME_ACCOUNTING
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
-- 
1.8.1.4
