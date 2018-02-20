Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751961AbeBTXZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNP4BF137942
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g8uht3naf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:03 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 07/12] Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
Date: Tue, 20 Feb 2018 15:25:07 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-7-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Andrea Parri <parri.andrea@gmail.com>

A memory consistency model is now available for the Linux kernel [1],
which "can (roughly speaking) be thought of as an automated version of
memory-barriers.txt" and which is (in turn) "accompanied by extensive
documentation on its use and its design".

Inform the (occasional) reader of memory-barriers.txt of these
developments.

[1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2

Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 479ecec80593..74ad222d11ed 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -14,7 +14,11 @@ DISCLAIMER
 This document is not a specification; it is intentionally (for the sake of
 brevity) and unintentionally (due to being human) incomplete. This document is
 meant as a guide to using the various memory barriers provided by Linux, but
-in case of any doubt (and there are many) please ask.
+in case of any doubt (and there are many) please ask.  Some doubts may be
+resolved by referring to the formal memory consistency model and related
+documentation at tools/memory-model/.  Nevertheless, even this memory
+model should be viewed as the collective opinion of its maintainers rather
+than as an infallible oracle.
 
 To repeat, this document is not a specification of what Linux expects from
 hardware.
-- 
2.5.2
