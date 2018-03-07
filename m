Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751211AbeCGR0A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2018 12:26:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w27HPeYn080567
        for <linux-arch@vger.kernel.org>; Wed, 7 Mar 2018 12:25:58 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gjk4ec1ge-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2018 12:25:58 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Mar 2018 12:25:57 -0500
Date: Wed, 7 Mar 2018 09:26:27 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 0/4] Documentation updates and fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180307172627.GA15805@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180307172627.5qu2L7JyVIaAqWs4e_EHsFzG-0-zzWPgMtEW4rSWxP0@z>

Hello!

This patch series adds some documentation and fixes to the Linux-kernel
memory model (LKMM):

1.	Add more text to meomry-barrier.txt to de-emphasize
	smp_read_barrier_depends().

2.	Remove mention of the now-obsolete docker and gentoo images
	from README.

3.	Add documentation for the new ISA2+pooncelock+pooncelock+pombonce
	litmus test.

4.	Update the removal of rb-dep, smp_read_barrier_depends(), and
	lockless_dereference() to reflect feedback.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                |   26 +++++++++++++++--------
 tools/memory-model/Documentation/cheatsheet.txt  |    6 ++---
 tools/memory-model/Documentation/explanation.txt |    4 +--
 tools/memory-model/README                        |   15 -------------
 tools/memory-model/linux-kernel.def              |    2 -
 tools/memory-model/litmus-tests/README           |    6 +++++
 6 files changed, 30 insertions(+), 29 deletions(-)
