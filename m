Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752602AbdGGT24 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 15:28:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67JSon6046954
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 15:28:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjfhvhv3d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 15:28:50 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 15:28:34 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v3 7/9] drivers/ata: Replace spin_unlock_wait() with lock/unlock pair
Date: Fri,  7 Jul 2017 12:28:24 -0700
In-Reply-To: <20170707192704.GA6144@linux.vnet.ibm.com>
References: <20170707192704.GA6144@linux.vnet.ibm.com>
Message-ID: <1499455706-9398-7-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-ide@vger.kernel.org
Message-ID: <20170707192824.eEWFA3cMYFjwo1zzAAvmC_if415H-V7JEXc9xJAdGi0@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore eliminates the spin_unlock_wait() call and
associated else-clause and hoists the then-clause's lock and unlock out of
the "if" statement.  This should be safe from a performance perspective
because according to Tejun there should be few if any drivers that don't
set their own error handler.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: <linux-ide@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/ata/libata-eh.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef68232b5222..779f6f18c1f4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -645,12 +645,11 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	 * completions are honored.  A scmd is determined to have
 	 * timed out iff its associated qc is active and not failed.
 	 */
+	spin_lock_irqsave(ap->lock, flags);
 	if (ap->ops->error_handler) {
 		struct scsi_cmnd *scmd, *tmp;
 		int nr_timedout = 0;
 
-		spin_lock_irqsave(ap->lock, flags);
-
 		/* This must occur under the ap->lock as we don't want
 		   a polled recovery to race the real interrupt handler
 
@@ -700,12 +699,11 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 		if (nr_timedout)
 			__ata_port_freeze(ap);
 
-		spin_unlock_irqrestore(ap->lock, flags);
 
 		/* initialize eh_tries */
 		ap->eh_tries = ATA_EH_MAX_TRIES;
-	} else
-		spin_unlock_wait(ap->lock);
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
 
 }
 EXPORT_SYMBOL(ata_scsi_cmd_error_handler);
-- 
2.5.2
