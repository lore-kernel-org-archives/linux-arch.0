Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:20930 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030230AbWILO6j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Sep 2006 10:58:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8CEwcS0017790
	for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2006 10:58:38 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] IRQ: Typedef the IRQ handler function type
Date: Tue, 12 Sep 2006 15:58:36 +0100
Message-Id: <20060912145836.26862.51701.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060912145834.26862.84739.stgit@warthog.cambridge.redhat.com>
References: <20060912145834.26862.84739.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Typedef the IRQ handler function type.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/interrupt.h |    7 ++++---
 kernel/irq/manage.c       |    4 +---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d5afee9..8a8d64f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,8 +64,10 @@ #define SA_TRIGGER_FALLING	IRQF_TRIGGER_
 #define SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
 #define SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
 
+typedef irqreturn_t (*irq_handler_t)(int, void *, struct pt_regs *);
+
 struct irqaction {
-	irqreturn_t (*handler)(int, void *, struct pt_regs *);
+	irq_handler_t handler;
 	unsigned long flags;
 	cpumask_t mask;
 	const char *name;
@@ -76,8 +78,7 @@ struct irqaction {
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
-extern int request_irq(unsigned int,
-		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
+extern int request_irq(unsigned int, irq_handler_t handler,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 92be519..6879202 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -427,8 +427,7 @@ EXPORT_SYMBOL(free_irq);
  *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+int request_irq(unsigned int irq, irq_handler_t handler,
 		unsigned long irqflags, const char *devname, void *dev_id)
 {
 	struct irqaction *action;
@@ -475,4 +474,3 @@ #endif
 	return retval;
 }
 EXPORT_SYMBOL(request_irq);
-
