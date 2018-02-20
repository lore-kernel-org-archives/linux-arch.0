Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751764AbeBTXXt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:23:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNNdOT118579
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:23:49 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g8umakcc1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:23:48 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:23:48 -0500
Date: Tue, 20 Feb 2018 15:24:05 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 0/12] Miscellaneous fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20180220232405.GA19274@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

Hello!

This RFC series adds some miscellaneous updates to the Linux kernel
memory model:

1.	Clarify the origin and scope of the tool name to avoid confusion
	between "memory model" and "memory management", courtesy of
	Andrea Parri.

2.	Move the maintainer list for LKMM to the main MAINTAINERS file,
	courtesy of Andrea Parri.

3.	Add memory-barriers.txt to the LKMM MAINTAINERS entry, courtesy
	of Andrea Parri.

4.	Add comments explaining the purpose of the various litmus tests.

5.	Fix punctuation errors in litmus-tests/README.

6.	Add Akira Yokosawa as an LKMM reviewer.

7.	Cross-reference tools/memory-model from memory-barriers.txt,
	courtesy of Andrea Parri and Akira Yokosawa.

8.	Fix description of data dependency barriers, courtesy of
	Nikolay Borisov.

9.	Add required herd7 version to README file.

10.	Add a S lock-based external-view litmus test, courtesy of Alan
	Stern.

11.	Convert underscores to hyphens in .bell and .cat files for
	consistency with typical cat-language code.

12.	Remove rb-dep, smp_read_barrier_depends, and lockless_dereference,
	which reflect recent Linux-kernel changes, courtesy of
	Alan Stern.

Changes since v1:

o	Applied feedback from v1 posting.

o	Squashing patches together, as promised in v1.

o	Added patches 7-10 and 12.

							Thanx, Paul

------------------------------------------------------------------------

 /tools/memory-model/MAINTAINERS                                                            |   15 -
 b/Documentation/memory-barriers.txt                                                        |    8 
 b/MAINTAINERS                                                                              |   18 ++
 b/tools/memory-model/Documentation/cheatsheet.txt                                          |    3 
 b/tools/memory-model/Documentation/explanation.txt                                         |   81 +++++-----
 b/tools/memory-model/MAINTAINERS                                                           |    2 
 b/tools/memory-model/README                                                                |   17 +-
 b/tools/memory-model/linux-kernel.bell                                                     |    9 -
 b/tools/memory-model/linux-kernel.cat                                                      |   15 -
 b/tools/memory-model/linux-kernel.def                                                      |    8 
 b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                   |    7 
 b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus                         |   10 +
 b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                         |   10 +
 b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus               |   41 +++++
 b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                  |    9 +
 b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus |   11 +
 b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus                        |   11 +
 b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                    |    8 
 b/tools/memory-model/litmus-tests/LB+poonceonces.litmus                                    |    7 
 b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                           |   11 +
 b/tools/memory-model/litmus-tests/MP+polocks.litmus                                        |   11 +
 b/tools/memory-model/litmus-tests/MP+poonceonces.litmus                                    |    7 
 b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                    |    8 
 b/tools/memory-model/litmus-tests/MP+porevlocks.litmus                                     |   11 +
 b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus                        |    8 
 b/tools/memory-model/litmus-tests/R+mbonceonces.litmus                                     |    9 +
 b/tools/memory-model/litmus-tests/R+poonceonces.litmus                                     |    8 
 b/tools/memory-model/litmus-tests/README                                                   |    4 
 b/tools/memory-model/litmus-tests/S+poonceonces.litmus                                     |    9 +
 b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus                       |    7 
 b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus                                    |    9 +
 b/tools/memory-model/litmus-tests/SB+poonceonces.litmus                                    |    8 
 b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                              |    8 
 b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus                |    8 
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus               |    9 +
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus               |    8 
 b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus    |   14 +
 40 files changed, 380 insertions(+), 88 deletions(-)
