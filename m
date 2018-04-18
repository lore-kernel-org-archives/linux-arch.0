Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40137 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeDRJkk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Apr 2018 05:40:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so2976711wrc.7
        for <linux-arch@vger.kernel.org>; Wed, 18 Apr 2018 02:40:40 -0700 (PDT)
Date: Wed, 18 Apr 2018 11:40:33 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add
 litmus test for multicopy atomicity
Message-ID: <20180418094033.GA3409@andrea>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
 <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180418094033.u87AwwMfwaZy15xzGUCgaSwAuyzlUwY-A4YwVz0Y8MQ@z>

On Mon, Apr 16, 2018 at 09:22:48AM -0700, Paul E. McKenney wrote:
> This commit adds a litmus test suggested by Alan Stern that is forbidden
> on multicopy atomic systems, but allowed on non-multicopy atomic systems.
> Note that other-multicopy atomic systems are examples of non-multicopy
> atomic systems.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus

We seem to be missing an entry in litmus-tests/README...


> 
> diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> new file mode 100644
> index 000000000000..991a2d6dec63
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> @@ -0,0 +1,31 @@
> +C SB+poonceoncescoh
> +
> +(*
> + * Result: Sometimes
> + *
> + * This litmus test demonstrates that LKMM is not multicopy atomic.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	WRITE_ONCE(*x, 1);
> +	r1 = READ_ONCE(*x);
> +	r2 = READ_ONCE(*y);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r3;
> +	int r4;
> +
> +	WRITE_ONCE(*y, 1);
> +	r3 = READ_ONCE(*y);
> +	r4 = READ_ONCE(*x);
> +}
> +
> +exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)

This test has a normalised name:  why don't use that?

  Andrea


> -- 
> 2.5.2
> 
