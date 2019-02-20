Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728703AbfBTCAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 21:00:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1K1xWFN027007
        for <linux-arch@vger.kernel.org>; Tue, 19 Feb 2019 21:00:10 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrs769p5f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 19 Feb 2019 21:00:10 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Feb 2019 02:00:09 -0000
Date: Tue, 19 Feb 2019 18:00:02 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] tools/memory-model: Fix comment in
 MP+poonceonces.litmus
Reply-To: paulmck@linux.ibm.com
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
Message-ID: <20190220020002.GC11787@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190220020002.trCQmQE2YaobEC6Qzyg64B4V5tqPB0vTHLIQGhVtPDo@z>

On Tue, Feb 19, 2019 at 11:55:22PM +0100, Andrea Parri wrote:
> The comment should say "Sometimes" for the result.

I queued both of these, thank you!   Just to be clear "Maybe" is "don't
care", so this patch is changing this litmus test from "LKMM can allow
or forbid, at its option" to "LKMM must allow".  Which should be fine,
given that the test has absolutely no ordering.

							Thanx, Paul

> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
>  tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> index b2b60b84fb9dc..172f0145301c5 100644
> --- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> @@ -1,7 +1,7 @@
>  C MP+poonceonces
>  
>  (*
> - * Result: Maybe
> + * Result: Sometimes
>   *
>   * Can the counter-intuitive message-passing outcome be prevented with
>   * no ordering at all?
> -- 
> 2.7.4
> 
