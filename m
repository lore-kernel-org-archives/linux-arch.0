Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbeCWPqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Mar 2018 11:46:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2NFiuXm056805
        for <linux-arch@vger.kernel.org>; Fri, 23 Mar 2018 11:46:10 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gw3jpar6y-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 23 Mar 2018 11:46:09 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 23 Mar 2018 11:46:08 -0400
Date: Fri, 23 Mar 2018 08:46:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 0/12] Reorganize RCU-related cat rules
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180323154651.GA28363@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mutt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180323154651.mYGixlv5EftYZgFqrqBb0BZSgXK-ARB5wpSzQ1fIdKk@z>

Hello!

This patch series reorganizes RCU-related cat-file rules:

1.	Renames link and rcu-path to rcu-link and rb, respectively.
	This avoids unfortunate name collisions with "link" the rule and
	"link" the concept.  Courtesy of Alan Stern.

2.	Redefines "rb" in terms of rcu-fence, explicitly expressing
	the fence-like properties of RCU grace periods.  Courtesy of
	Alan Stern.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  261 +++++++++++++++++++++++++-----------------
 linux-kernel.cat              |   49 ++++---
 2 files changed, 184 insertions(+), 126 deletions(-)
