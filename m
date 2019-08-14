Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728388AbfHNXYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 19:24:19 -0400
Date: Wed, 14 Aug 2019 16:24:04 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 0/2] tools/memory-model: Update comment of jugdelitmus.sh
Message-ID: <20190814232404.GC28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
 <20190812180649.GM28441@linux.ibm.com>
 <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190814232404.qltepomeHCGrrFrK75GsF7M_n6jm8ytxpGi6YqjCY9g@z>

On Thu, Aug 15, 2019 at 12:11:36AM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> I see some inconsistency between the header comment of judgelitmus.sh
> and the updated script.
> 
> This patch set updates the header. It is relative to current lkmm-dev
> of -rcu.
> 
> Patch 1/2 corresponds to ("tools/memory-model: Move from
> .AArch64.litmus.out to .litmus.AArch.out").
> 
> Patch 2/2 corresponds to ("tools/memory-model: Add data-race
> capabilities to judgelitmus.sh").
> 
> You should be able to use each patch as a fix-up commit respectively.
> I'm OK either with them applied at the head of the branch or
> with them merged into your commits.

Good catches, thank you for looking these commits over!  I will squash
your changes into the original commits with attribution.

							Thanx, Paul

>         Thanks, Akira
> --
> Akira Yokosawa (2):
>   tools/memory-model: Reflect updated file name convention in
>     judgelitmus.sh
>   tools/memory-model: Mention data-race capability in jugdelitmus.sh's
>     header
> 
>  tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
