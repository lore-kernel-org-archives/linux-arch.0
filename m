Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729841AbeGPScW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxF90076060
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8vwrs4mj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:49 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 03/14] MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
Date: Mon, 16 Jul 2018 11:05:54 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-3-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180554.ebUNlzxRXYmUhfNjn6B4jcwdxauLCIA8Ry9WyRwjQZ4@z>

From: Palmer Dabbelt <palmer@sifive.com>

Dan runs the RISC-V memory model working group.  I've been forwarding
him LKMM emails that end up in my inbox, but I'm far from an expert in
this stuff.  He requested to be added as a reviewer, which seems sane to
me as it'll take a human out of the loop.

CC: Daniel Lustig <dlustig@nvidia.com>
Acked-by: Daniel Lustig <dlustig@nvidia.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..ac8ed55dbe9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
+R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-- 
2.17.1
