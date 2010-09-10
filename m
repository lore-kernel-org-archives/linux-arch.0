Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604Ab0IJQZL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Sep 2010 12:25:11 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/17] smc91x: Add missing #inclusion of <linux/irq.h>
Date: Fri, 10 Sep 2010 17:24:53 +0100
Message-ID: <20100910162453.20817.8854.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
References: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Nicolas Pitre <nico@fluxnic.net>
Message-ID: <20100910162453.Nvxu5jHGarmZFa0qSpbZwGFbq6eaMYF4lA65tD0Y9QM@z>

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

