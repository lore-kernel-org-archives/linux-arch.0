From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: LKMM
Date: Mon, 6 Jul 2020 14:36:33 -0700
Message-ID: <20200706213633.GL9247@paulmck-ThinkPad-P72>
References: <20200706190324.20638-1-grandmaster@al2klimov.de>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgGFVge (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 17:36:34 -0400
Content-Disposition: inline
In-Reply-To: <20200706190324.20638-1-grandmaster@al2klimov.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 09:03:24PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Queued, thank you!

						Thanx, Paul

> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  tools/memory-model/Documentation/references.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
> index b177f3e4a614..9b2d7d56e842 100644
> --- a/tools/memory-model/Documentation/references.txt
> +++ b/tools/memory-model/Documentation/references.txt
> @@ -103,7 +103,7 @@ o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
>  
>  o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
>  	semantics of the weak consistency model specification language
> -	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
> +	cat". CoRR abs/1608.07531 (2016). https://arxiv.org/abs/1608.07531
>  
>  
>  Memory-model comparisons
> -- 
> 2.27.0
> 
