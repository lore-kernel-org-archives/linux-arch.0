Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfCRRuT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Mar 2019 13:50:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IHhuvC009784
        for <linux-arch@vger.kernel.org>; Mon, 18 Mar 2019 13:50:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2raex1326a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 18 Mar 2019 13:50:17 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Mar 2019 17:50:16 -0000
Date: Mon, 18 Mar 2019 10:50:59 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: LKMM patch status
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190318175059.GA3322@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190318175059.etkb1lJqrebBnR7fd_CKsnvoS97fq-KpCAoDqLEaWW8@z>

Hello!


pick 0172d9e32203 tools/memory-model: Rename some RCU relations
pick 284749b0aebb tools/memory-model: Refactor some RCU relations
pick a3f600d92da5 tools/memory-model: Add SRCU support
pick ad9fd20b6dad tools/memory-model: Update README for addition of SRCU
pick 648e717586f2 tools/memory-model: Update Documentation/explanation.txt to include SRCU support
pick 9393998e9ee0 tools/memory-model: Dynamically check SRCU lock-to-unlock matching
pick 034fb712a620 tools/memory-model: Avoid duplicating herdtools versions

	Ready to go, sent for inclusion in tip, and will presumably show
	up there soon.

	http://lkml.kernel.org/r/20190213173650.GA26078@linux.ibm.com

pick 487ecc460732 sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
pick db467147f131 locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()
pick f1887143f598 Documentation/atomic_t: Clarify signed vs unsigned

	These have the needed acks/reviews, so I will send them as RFC
	patches within the next week or two.

pick ece264389af9 tools/memory-model: Make scripts be executable
pick fd4b7b3c6c0d tools/memory-model: Fix comment in MP+poonceonces.litmus
pick e9cc6e9437e2 tools/memory-model: Do not use "herd" to refer to "herd7"
pick 093e4c7dcf79 docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER EFFECTS" section

	These all need at least one Reviewed-by or Acked-by.

								Thanx, Paul
