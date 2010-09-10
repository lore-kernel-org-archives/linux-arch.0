From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/17] smc91x: Add missing #inclusion of <linux/irq.h>
Date: Fri, 10 Sep 2010 17:10:48 +0100
Message-ID: <20100910161048.20226.59383.stgit@warthog.procyon.org.uk>
References: <20100910161002.20226.27995.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354Ab0IJQK7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Sep 2010 12:10:59 -0400
In-Reply-To: <20100910161002.20226.27995.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Nicolas Pitre <nico@fluxnic.net>

Add missing #inclusion of <linux/irq.h>.  Without it, the following error can
occur with the irqflags fixup patches applied:

drivers/net/smc91x.c: In function 'smc_probe':
drivers/net/smc91x.c:1987:2: error: implicit declaration of function 'irq_canonicalize'

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---

 drivers/net/smc91x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 10cf0cb..726df61 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -72,6 +72,7 @@ static const char version[] =
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/crc32.h>
