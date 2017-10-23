Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751628AbdJWVHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7Mq9102880
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsnegxu3t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 02/19] EDAC, altera: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:12 -0700
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Message-ID: <1508792849-3115-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Borislav Petkov <bp@alien8.de>
Message-ID: <20171023210712.83T6w3sFIabSDDMNicr-ZSrfMs8BZB0ccVgXGXZjX60@z>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the Altera EDAC code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/edac/altera_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 346c4987b284..11d6419788c2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -175,11 +175,11 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 	/*
 	 * To trigger the error, we need to read the data back
 	 * (the data was written with errors above).
-	 * The ACCESS_ONCE macros and printk are used to prevent the
+	 * The READ_ONCE macros and printk are used to prevent the
 	 * the compiler optimizing these reads out.
 	 */
-	reg = ACCESS_ONCE(ptemp[0]);
-	read_reg = ACCESS_ONCE(ptemp[1]);
+	reg = READ_ONCE(ptemp[0]);
+	read_reg = READ_ONCE(ptemp[1]);
 	/* Force Read */
 	rmb();
 
@@ -618,7 +618,7 @@ static ssize_t altr_edac_device_trig(struct file *file,
 	for (i = 0; i < (priv->trig_alloc_sz / sizeof(*ptemp)); i++) {
 		/* Read data so we're in the correct state */
 		rmb();
-		if (ACCESS_ONCE(ptemp[i]))
+		if (READ_ONCE(ptemp[i]))
 			result = -1;
 		/* Toggle Error bit (it is latched), leave ECC enabled */
 		writel(error_mask, (drvdata->base + priv->set_err_ofst));
@@ -635,7 +635,7 @@ static ssize_t altr_edac_device_trig(struct file *file,
 
 	/* Read out written data. ECC error caused here */
 	for (i = 0; i < ALTR_TRIGGER_READ_WRD_CNT; i++)
-		if (ACCESS_ONCE(ptemp[i]) != i)
+		if (READ_ONCE(ptemp[i]) != i)
 			edac_printk(KERN_ERR, EDAC_DEVICE,
 				    "Read doesn't match written data\n");
 
-- 
2.5.2
