Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751429AbeAYJev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 04:34:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0P9Ycka036130
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2018 04:34:50 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fqaxhvf87-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2018 04:34:50 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 25 Jan 2018 04:34:49 -0500
Date: Thu, 25 Jan 2018 01:34:40 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180125093440.GA875@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com
Message-ID: <20180125093440.KdPoTHzPzmUvbncALPHbDkvgab59xiuwN_BOg04Z9lY@z>

Hello, Ingo,

This pull request contains a single commit that adds a memory model to
the tools directory.  This memory model can (roughly speaking) be thought
of as an automated version of memory-barriers.txt.  It is written in the
"cat" language, which is executable by the externally provided "herd7"
simulator, which exhaustively explores the state space of small litmus
tests.

This memory model is accompanied by extensive documentation on its use
and its design.  Two versions have been sent to LKML and feedback
incorporated:

1.	http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com
2.	http://lkml.kernel.org/r/20180119035855.GA29296@linux.vnet.ibm.com

This model has been presented and demoed at a number of Linux gatherings,
including the 2016 LinuxCon EU, the 2016 Linux Plumbers Conference,
the 2016 Linux Kernel Summit, the 2017 linux.conf.au, and the 2017 Linux
Plumbers Conference, which featured a workshop helping a number of Linux
kernel hackers install and use the tool.

This memory model has matured to the point where it would be good to include
it in the Linux kernel, for example, to allow it to track changes as new
hardware and use cases are added.  We expect the rate of change to be similar
to that of Documentation/memory-barriers.txt.

This memory model is available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git 

for you to fetch changes up to 1c27b644c0fdbc61e113b8faee14baeb8df32486:

  Automate memory-barriers.txt; provide Linux-kernel memory model (2018-01-24 20:53:49 -0800)

----------------------------------------------------------------
Paul E. McKenney (1):
      Automate memory-barriers.txt; provide Linux-kernel memory model

 tools/memory-model/Documentation/cheatsheet.txt    |   30 +
 tools/memory-model/Documentation/explanation.txt   | 1840 ++++++++++++++++++++
 tools/memory-model/Documentation/recipes.txt       |  570 ++++++
 tools/memory-model/Documentation/references.txt    |  107 ++
 tools/memory-model/MAINTAINERS                     |   15 +
 tools/memory-model/README                          |  220 +++
 tools/memory-model/linux-kernel.bell               |   53 +
 tools/memory-model/linux-kernel.cat                |  124 ++
 tools/memory-model/linux-kernel.cfg                |   21 +
 tools/memory-model/linux-kernel.def                |  108 ++
 .../litmus-tests/CoRR+poonceonce+Once.litmus       |   19 +
 .../litmus-tests/CoRW+poonceonce+Once.litmus       |   18 +
 .../litmus-tests/CoWR+poonceonce+Once.litmus       |   18 +
 .../litmus-tests/CoWW+poonceonce.litmus            |   11 +
 .../litmus-tests/IRIW+mbonceonces+OnceOnce.litmus  |   35 +
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus  |   33 +
 .../litmus-tests/ISA2+poonceonces.litmus           |   28 +
 ...cerelease+poacquirerelease+poacquireonce.litmus |   28 +
 .../litmus-tests/LB+ctrlonceonce+mbonceonce.litmus |   23 +
 .../LB+poacquireonce+pooncerelease.litmus          |   21 +
 .../litmus-tests/LB+poonceonces.litmus             |   21 +
 .../litmus-tests/MP+onceassign+derefonce.litmus    |   25 +
 tools/memory-model/litmus-tests/MP+polocks.litmus  |   24 +
 .../litmus-tests/MP+poonceonces.litmus             |   20 +
 .../MP+pooncerelease+poacquireonce.litmus          |   20 +
 .../memory-model/litmus-tests/MP+porevlocks.litmus |   24 +
 .../litmus-tests/MP+wmbonceonce+rmbonceonce.litmus |   22 +
 .../memory-model/litmus-tests/R+mbonceonces.litmus |   21 +
 .../memory-model/litmus-tests/R+poonceonces.litmus |   19 +
 tools/memory-model/litmus-tests/README             |  125 ++
 .../memory-model/litmus-tests/S+poonceonces.litmus |   19 +
 .../S+wmbonceonce+poacquireonce.litmus             |   20 +
 .../litmus-tests/SB+mbonceonces.litmus             |   23 +
 .../litmus-tests/SB+poonceonces.litmus             |   21 +
 .../litmus-tests/WRC+poonceonces+Once.litmus       |   27 +
 .../WRC+pooncerelease+rmbonceonce+Once.litmus      |   28 +
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |   33 +
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus     |   32 +
 ...ooncerelease+poacquirerelease+mbonceonce.litmus |   28 +
 tools/memory-model/lock.cat                        |   99 ++
 40 files changed, 3973 insertions(+)
 create mode 100644 tools/memory-model/Documentation/cheatsheet.txt
 create mode 100644 tools/memory-model/Documentation/explanation.txt
 create mode 100644 tools/memory-model/Documentation/recipes.txt
 create mode 100644 tools/memory-model/Documentation/references.txt
 create mode 100644 tools/memory-model/MAINTAINERS
 create mode 100644 tools/memory-model/README
 create mode 100644 tools/memory-model/linux-kernel.bell
 create mode 100644 tools/memory-model/linux-kernel.cat
 create mode 100644 tools/memory-model/linux-kernel.cfg
 create mode 100644 tools/memory-model/linux-kernel.def
 create mode 100644 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
 create mode 100644 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
 create mode 100644 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+polocks.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+porevlocks.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/R+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/R+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/README
 create mode 100644 tools/memory-model/litmus-tests/S+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/SB+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/SB+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
 create mode 100644 tools/memory-model/lock.cat
