Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751282AbdJWVHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7LCC124475
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dskcm4tta-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 03/19] firmware/ivc: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:13 -0700
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Message-ID: <1508792849-3115-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20171023210713.FHQMZ_W_KkJpDz2ukxnkUhi-jBDjuGqMqlhO5jjf6J0@z>

From: Mark Rutland <mark.rutland@arm.com>

workqueue: kill off ACCESS_ONCE()

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
step, this patch converts the Tegra IVC code and comments to use
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
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/firmware/tegra/ivc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
index a01461d63f68..00de793e6423 100644
--- a/drivers/firmware/tegra/ivc.c
+++ b/drivers/firmware/tegra/ivc.c
@@ -99,11 +99,11 @@ static inline bool tegra_ivc_empty(struct tegra_ivc *ivc,
 {
 	/*
 	 * This function performs multiple checks on the same values with
-	 * security implications, so create snapshots with ACCESS_ONCE() to
+	 * security implications, so create snapshots with READ_ONCE() to
 	 * ensure that these checks use the same values.
 	 */
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * Perform an over-full check to prevent denial of service attacks
@@ -124,8 +124,8 @@ static inline bool tegra_ivc_empty(struct tegra_ivc *ivc,
 static inline bool tegra_ivc_full(struct tegra_ivc *ivc,
 				  struct tegra_ivc_header *header)
 {
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * Invalid cases where the counters indicate that the queue is over
@@ -137,8 +137,8 @@ static inline bool tegra_ivc_full(struct tegra_ivc *ivc,
 static inline u32 tegra_ivc_available(struct tegra_ivc *ivc,
 				      struct tegra_ivc_header *header)
 {
-	u32 tx = ACCESS_ONCE(header->tx.count);
-	u32 rx = ACCESS_ONCE(header->rx.count);
+	u32 tx = READ_ONCE(header->tx.count);
+	u32 rx = READ_ONCE(header->rx.count);
 
 	/*
 	 * This function isn't expected to be used in scenarios where an
@@ -151,8 +151,8 @@ static inline u32 tegra_ivc_available(struct tegra_ivc *ivc,
 
 static inline void tegra_ivc_advance_tx(struct tegra_ivc *ivc)
 {
-	ACCESS_ONCE(ivc->tx.channel->tx.count) =
-		ACCESS_ONCE(ivc->tx.channel->tx.count) + 1;
+	WRITE_ONCE(ivc->tx.channel->tx.count,
+		   READ_ONCE(ivc->tx.channel->tx.count) + 1);
 
 	if (ivc->tx.position == ivc->num_frames - 1)
 		ivc->tx.position = 0;
@@ -162,8 +162,8 @@ static inline void tegra_ivc_advance_tx(struct tegra_ivc *ivc)
 
 static inline void tegra_ivc_advance_rx(struct tegra_ivc *ivc)
 {
-	ACCESS_ONCE(ivc->rx.channel->rx.count) =
-		ACCESS_ONCE(ivc->rx.channel->rx.count) + 1;
+	WRITE_ONCE(ivc->rx.channel->rx.count,
+		   READ_ONCE(ivc->rx.channel->rx.count) + 1);
 
 	if (ivc->rx.position == ivc->num_frames - 1)
 		ivc->rx.position = 0;
@@ -428,7 +428,7 @@ int tegra_ivc_notified(struct tegra_ivc *ivc)
 
 	/* Copy the receiver's state out of shared memory. */
 	tegra_ivc_invalidate(ivc, ivc->rx.phys + offset);
-	state = ACCESS_ONCE(ivc->rx.channel->tx.state);
+	state = READ_ONCE(ivc->rx.channel->tx.state);
 
 	if (state == TEGRA_IVC_STATE_SYNC) {
 		offset = offsetof(struct tegra_ivc_header, tx.count);
-- 
2.5.2
