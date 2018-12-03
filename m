Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbeLCXEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2018 18:04:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3N3p4T051610
        for <linux-arch@vger.kernel.org>; Mon, 3 Dec 2018 18:04:15 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5ddngy32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 03 Dec 2018 18:04:15 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 23:04:14 -0000
Date: Mon, 3 Dec 2018 15:04:11 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 0/3] Updates to the formal memory model
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20181203230411.GA27476@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20181203230411.0LRIwpPNEU34UzaoKjvNuUdzCNlj_9Pu5sjd_d0Bjsc@z>

Hello, Ingo!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model.  These patches are ready for inclusion into -tip.

1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.

2.	Add scripts to check github litmus tests.

3.	Make scripts take "-j" abbreviation for "--jobs".

There is another series in preparation to model SRCU, but this series
requires hot-off-the presses changes to the herd tool that have not yet
been released.  This SRCU series is therefore targeting the merge window
after the upcoming one.  People wishing to experiment with the prototype
SRCU model may obtain it from my -rcu tree at branch "dev", and use
a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
version 7.51+2(dev), which is (commit 10403b24070c) or later.

							Thanx, Paul

------------------------------------------------------------------------

 .gitignore                 |    1 
 README                     |    2 
 linux-kernel.bell          |    3 
 linux-kernel.cat           |    4 -
 linux-kernel.def           |    1 
 scripts/README             |   70 ++++++++++++++++++++++
 scripts/checkalllitmus.sh  |   53 +++++++----------
 scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
 scripts/checklitmus.sh     |   74 +++--------------------
 scripts/checklitmushist.sh |   60 +++++++++++++++++++
 scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
 scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
 scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
 scripts/newlitmushist.sh   |   61 +++++++++++++++++++
 scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
 scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
 16 files changed, 757 insertions(+), 97 deletions(-)
