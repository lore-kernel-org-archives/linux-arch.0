From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] tools/memory-model: Fix comment in
 MP+poonceonces.litmus
Date: Tue, 19 Feb 2019 18:00:02 -0800
Message-ID: <20190220020002.GC11787@linux.ibm.com>
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

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
