Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47057 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCX2J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2018 18:28:09 -0500
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
References: <20181203230411.GA27476@linux.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
Date: Tue, 4 Dec 2018 08:28:03 +0900
MIME-Version: 1.0
In-Reply-To: <20181203230411.GA27476@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Message-ID: <20181203232803.6SalYjA2SYrReT0kGke-ZDgrbZyCbpy0Mx-WtfLnX7w@z>

On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
> Hello, Ingo!
> 
> This series contains updates to the Linux kernel's formal memory model
> in tools/memory-model.  These patches are ready for inclusion into -tip.
> 
> 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
> 
> 2.	Add scripts to check github litmus tests.
> 
> 3.	Make scripts take "-j" abbreviation for "--jobs".
> 
> There is another series in preparation to model SRCU, but this series
> requires hot-off-the presses changes to the herd tool that have not yet
> been released.  This SRCU series is therefore targeting the merge window
> after the upcoming one.  People wishing to experiment with the prototype
> SRCU model may obtain it from my -rcu tree at branch "dev", and use
> a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
> version 7.51+2(dev), which is (commit 10403b24070c) or later.

On the master branch of herdtools7, SRCU support was added in version
7.51+4(dev), which is commit 6ec9da1f4d58, or later.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  .gitignore                 |    1 
>  README                     |    2 
>  linux-kernel.bell          |    3 
>  linux-kernel.cat           |    4 -
>  linux-kernel.def           |    1 
>  scripts/README             |   70 ++++++++++++++++++++++
>  scripts/checkalllitmus.sh  |   53 +++++++----------
>  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
>  scripts/checklitmus.sh     |   74 +++--------------------
>  scripts/checklitmushist.sh |   60 +++++++++++++++++++
>  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
>  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
>  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
>  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
>  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
>  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
>  16 files changed, 757 insertions(+), 97 deletions(-)
> 
