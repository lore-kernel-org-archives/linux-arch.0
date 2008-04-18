Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38774 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758267AbYDRG5a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2008 02:57:30 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 18 Apr 2008 16:56:18 +1000
Subject: [PATCH 3/3] Use __weak macro for smp_setup_processor_id
Message-ID: <20080418065728.31AF4DE255@ozlabs.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20080418065618.ecF_0JYn_XvbDA_7oPckvkUEvRreFGn_a3Et-k1-9GU@z>

Use the __weak macro instead of the longer __attribute__ ((weak)) form

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/init/main.c	2008-04-18 16:44:32.000000000 +1000
+++ linux-work/init/main.c	2008-04-18 16:44:37.000000000 +1000
@@ -500,7 +500,7 @@ static void __init boot_cpu_init(void)
 	cpu_set(cpu, cpu_possible_map);
 }
 
-void __init __attribute__((weak)) smp_setup_processor_id(void)
+void __init __weak smp_setup_processor_id(void)
 {
 }
 
