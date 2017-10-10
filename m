Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755606AbdJJAWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JOLO109586
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dggmafaxy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:53 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:53 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 03/15] drivers/net/ethernet/qlogic/qed: Fix __qed_spq_block() ordering
Date: Mon,  9 Oct 2017 17:22:37 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com, netdev@vger.kernel.org
Message-ID: <20171010002237.0aqnlweqK_bWx7njPD7oe643olQzD4cJEn94iV5c6ao@z>

The __qed_spq_block() function expects an smp_read_barrier_depends()
to order a prior READ_ONCE() against a later load that does not depend
on the prior READ_ONCE(), an expectation that can fail to be met.
This commit therefore replaces the READ_ONCE() with smp_load_acquire()
and removes the smp_read_barrier_depends().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ariel Elior <Ariel.Elior@cavium.com>
Cc: <everest-linux-l2@cavium.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_spq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index be48d9abd001..c1237ec58b6c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -97,9 +97,7 @@ static int __qed_spq_block(struct qed_hwfn *p_hwfn,
 
 	while (iter_cnt--) {
 		/* Validate we receive completion update */
-		if (READ_ONCE(comp_done->done) == 1) {
-			/* Read updated FW return value */
-			smp_read_barrier_depends();
+		if (smp_load_acquire(&comp_done->done) == 1) { /* ^^^ */
 			if (p_fw_ret)
 				*p_fw_ret = comp_done->fw_return_code;
 			return 0;
-- 
2.5.2
