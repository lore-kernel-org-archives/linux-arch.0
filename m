From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56
 in compatibility table
Date: Wed, 24 Jun 2020 00:57:23 +0200
Message-ID: <20200623225723.GA418699@andrea>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
 <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFWW5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 18:57:32 -0400
Content-Disposition: inline
In-Reply-To: <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr

On Wed, Jun 24, 2020 at 07:06:02AM +0900, Akira Yokosawa wrote:
> From 89f96cba0db5643b1d22a0fe740f4c5cac788b29 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Wed, 24 Jun 2020 06:56:43 +0900
> Subject: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
> 
> herdtools7 7.56 is going to be released in the week of 22 Jun 2020.
> Mention the exact version in the compatibility table.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 90af203c3cf1..ecb7385376bf 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -54,7 +54,7 @@ klitmus7 Compatibility Table
>  	     -- 4.18  7.48 --
>  	4.15 -- 4.19  7.49 --
>  	4.20 -- 5.5   7.54 --
> -	5.6  --       HEAD
> +	5.6  --       7.56 --
>  	============  ==========
>  
>  
> -- 
> 2.17.1
> 
> 
