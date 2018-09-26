Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbeI0AnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QIOCek146437
        for <linux-arch@vger.kernel.org>; Wed, 26 Sep 2018 14:28:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mre7buprk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 26 Sep 2018 14:28:52 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 14:28:51 -0400
Date: Wed, 26 Sep 2018 11:28:46 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 0/5] Updates to the formal memory model
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180926182845.GA24839@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180926182846._R7Ngl3gDJWeH7vdSHbL3gLv947o4H6UWbdmMsGsvok@z>

Hello, Ingo!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model, along with corresponding changes in documentation
and Linux-kernel code.  These patches are ready for inclusion into -tip.

1.	Document litmus-test naming scheme.

2.	Add extra ordering for locks and remove it for ordinary
	release/acquire, courtesy of Alan Stern.

3.	Fix a README typo, courtesy of SeongJae Park.

4.	Expand the list of LKMM limitations.

5.	Replace smp_cond_acquire() with smp_cond_load_acquire(),
	courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                                          |    3 
 tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
 tools/memory-model/Documentation/recipes.txt                               |    2 
 tools/memory-model/README                                                  |   39 ++
 tools/memory-model/linux-kernel.cat                                        |    8 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
 tools/memory-model/litmus-tests/README                                     |  104 +++++
 7 files changed, 293 insertions(+), 56 deletions(-)
