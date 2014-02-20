From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] Sparc: sparc_cpu_model isn't in asm/system.h any more [ver #2]
Date: Thu, 20 Feb 2014 16:08:12 +0000
Message-ID: <17732.1392912492@warthog.procyon.org.uk>
References: <20140212154559.2405.3104.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbaBTQIX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Feb 2014 11:08:23 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, davem@davemloft.net
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


sparc_cpu_model isn't in asm/system.h any more, so remove a comment about it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: sparclinux@vger.kernel.org
---

 drivers/sbus/char/jsflash.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 6b4678a..4ccb5d8 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -507,7 +507,6 @@ static int jsflash_init(void)
 	}
 
 	/* Let us be really paranoid for modifications to probing code. */
-	/* extern enum sparc_cpu sparc_cpu_model; */ /* in <asm/system.h> */
 	if (sparc_cpu_model != sun4m) {
 		/* We must be on sun4m because we use MMU Bypass ASI. */
 		return -ENXIO;
