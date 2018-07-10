Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeGJOfI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2018 10:35:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so14840748wrt.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Jul 2018 07:35:08 -0700 (PDT)
Date: Tue, 10 Jul 2018 16:34:59 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Message-ID: <20180710143459.GA10527@andrea>
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Message-ID: <20180710143459.IMIvK9SiMXvnLBaX9MjqkWFYHpsZ4p4t0NkRnf0VrCI@z>

On Tue, Jul 10, 2018 at 12:02:23PM +0200, Andrea Parri wrote:
> Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> with smp_cond_load_acquire()") by updating the documentation accordingly.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/memory-barriers.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 0d8d7ef131e9a..987a4e6cc0cd8 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -471,8 +471,8 @@ And a couple of implicit varieties:
>       operations after the ACQUIRE operation will appear to happen after the
>       ACQUIRE operation with respect to the other components of the system.
>       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> -     semantics from relying on a control dependency and smp_rmb().
> +     and smp_cond_load_acquire() operations. The later builds the necessary
> +     ACQUIRE semantics from relying on a control dependency and smp_rmb().

Still not completely accurate: smp_rmb() would better be replaced by
smp_acquire__after_ctrl_dep() (arm64 excluded).  Mmh... I think I'll
just remove that "The latter builds the [...]" and resend; thoughts?

  Andrea


>  
>       Memory operations that occur before an ACQUIRE operation may appear to
>       happen after it completes.
> -- 
> 2.7.4
> 
