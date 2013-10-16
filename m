From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/17] xtensa: mark ccount as continuous clocksource
Date: Thu, 17 Oct 2013 02:42:18 +0400
Message-ID: <1381963348-29448-8-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:32781 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762049Ab3JPWm5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:57 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so1093175lab.7
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:56 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Max Filippov <jcmvbkbc@gmail.com>

From: Baruch Siach <baruch@tkos.co.il>

This allows ccount to be used as highres timer.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 9af3dd8..26eb6a9 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -46,6 +46,7 @@ static struct clocksource ccount_clocksource = {
 	.rating = 200,
 	.read = ccount_read,
 	.mask = CLOCKSOURCE_MASK(32),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static int ccount_timer_set_next_event(unsigned long delta,
-- 
1.8.1.4
