Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:10372 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYE0IKK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 04:10:10 -0400
Received: from bagnes.atmel.com ([10.175.100.4])
	by sjogate2.atmel.com (8.13.6/8.13.6) with ESMTP id m4R89SQf028666
	for <linux-arch@vger.kernel.org>; Tue, 27 May 2008 01:09:29 -0700 (PDT)
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: [PATCH] avr32: Fix cpufreq oops when ondemand governor is default
Date: Tue, 27 May 2008 09:47:42 +0200
Message-ID: <1211874462-29287-1-git-send-email-haavard.skinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Message-ID: <20080527074742.Wg3twhjrbmNnew5i23ilofm-BW7dTMcUHKGxUzAEtTE@z>

Move the AP7 cpufreq driver to late_initcall() so that we don't try to
bring up cpufreq until the governor is ready. x86 also uses
late_initcall() for this.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
While looking around, I spotted lots of other architectures using
arch_initcall() for their cpufreq drivers. I would expect them to have
the same problem when a non-trivial default governor is selected.

 arch/avr32/mach-at32ap/cpufreq.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/avr32/mach-at32ap/cpufreq.c b/arch/avr32/mach-at32ap/cpufreq.c
index 235524b..5dd8d25 100644
--- a/arch/avr32/mach-at32ap/cpufreq.c
+++ b/arch/avr32/mach-at32ap/cpufreq.c
@@ -108,5 +108,4 @@ static int __init at32_cpufreq_init(void)
 {
 	return cpufreq_register_driver(&at32_driver);
 }
-
-arch_initcall(at32_cpufreq_init);
+late_initcall(at32_cpufreq_init);
-- 
1.5.5.1

