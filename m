Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbeLCXvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2018 18:51:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3Nn0EI036554
        for <linux-arch@vger.kernel.org>; Mon, 3 Dec 2018 18:51:31 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p5c1jnkvp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 03 Dec 2018 18:51:31 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 23:51:31 -0000
Date: Mon, 3 Dec 2018 15:51:27 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
Reply-To: paulmck@linux.ibm.com
References: <20181203230411.GA27476@linux.ibm.com>
 <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
Message-ID: <20181203235127.GS4170@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Message-ID: <20181203235127.q6LaspOVpE1sCk4bnUEfVnNdryh8T_-JwwxcmwlY_s0@z>

On Tue, Dec 04, 2018 at 08:28:03AM +0900, Akira Yokosawa wrote:
> On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
> > Hello, Ingo!
> > 
> > This series contains updates to the Linux kernel's formal memory model
> > in tools/memory-model.  These patches are ready for inclusion into -tip.
> > 
> > 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
> > 
> > 2.	Add scripts to check github litmus tests.
> > 
> > 3.	Make scripts take "-j" abbreviation for "--jobs".
> > 
> > There is another series in preparation to model SRCU, but this series
> > requires hot-off-the presses changes to the herd tool that have not yet
> > been released.  This SRCU series is therefore targeting the merge window
> > after the upcoming one.  People wishing to experiment with the prototype
> > SRCU model may obtain it from my -rcu tree at branch "dev", and use
> > a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
> > version 7.51+2(dev), which is (commit 10403b24070c) or later.
> 
> On the master branch of herdtools7, SRCU support was added in version
> 7.51+4(dev), which is commit 6ec9da1f4d58, or later.

It has been working for me with version 7.51+2(dev), but perhaps I
have just been getting lucky.  It wouldn't be the first time!  ;-)

							Thanx, Paul

>         Thanks, Akira
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  .gitignore                 |    1 
> >  README                     |    2 
> >  linux-kernel.bell          |    3 
> >  linux-kernel.cat           |    4 -
> >  linux-kernel.def           |    1 
> >  scripts/README             |   70 ++++++++++++++++++++++
> >  scripts/checkalllitmus.sh  |   53 +++++++----------
> >  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
> >  scripts/checklitmus.sh     |   74 +++--------------------
> >  scripts/checklitmushist.sh |   60 +++++++++++++++++++
> >  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
> >  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
> >  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
> >  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
> >  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
> >  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
> >  16 files changed, 757 insertions(+), 97 deletions(-)
> > 
> 
