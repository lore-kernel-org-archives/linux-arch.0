Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45784 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbfDBOtU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2019 10:49:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so17016815wra.12
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2019 07:49:20 -0700 (PDT)
Date: Tue, 2 Apr 2019 16:49:11 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for
 synchronize_srcu_expedited()
Message-ID: <20190402144911.GA10044@andrea>
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-8-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326234133.24962-8-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190402144911.q5iAk4OclKB8AystBSKxuB0zVzAqhr1JbRHOp8rGiU0@z>

On Tue, Mar 26, 2019 at 04:41:20PM -0700, Paul E. McKenney wrote:
> Given that synchronize_rcu_expedited() is supported, this commit adds
> support for synchronize_srcu_expedited().
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  tools/memory-model/linux-kernel.def | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 0c3f0ef486f4..551eeaa389d4 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
>  srcu_read_lock(X)  __srcu{srcu-lock}(X)
>  srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> +synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }

This and the other patches from the series do not apply to "tip/core/rcu"
(from the Subject), but this seems straightforward enough:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


>  
>  // Atomic
>  atomic_read(X) READ_ONCE(*X)
> -- 
> 2.17.1
> 
