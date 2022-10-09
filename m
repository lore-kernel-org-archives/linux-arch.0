Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED06C433FE
	for <linux-arch@archiver.kernel.org>; Sun,  9 Oct 2022 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJILKF (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 9 Oct 2022 07:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJILKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 07:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96C11A2A;
        Sun,  9 Oct 2022 04:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A99860B36;
        Sun,  9 Oct 2022 11:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C4AC433D6;
        Sun,  9 Oct 2022 11:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665313801;
        bh=V01vuyqwZci7AkmO4Lse2j82kGbZfEmmOuRsGCe1P20=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q7Aw9qmZHSl9OGgYyw08jxGtR0iMBzEhEFIMXWq3XaNu+wDmMfa9RUSjiGLo7bZrN
         t8q4rV6cspXHHseXOy96xm/yVymPS07vn/eoSPGNQDFwpSq6Zwi4rYZXOVEV0JcpS9
         HmoOpjIKQXJfibati0xigSURmRNKZfCqISJLhIDs2Tib8+8B7k3i9NRiOAiRORlOVM
         Ymrc4ARUtx7L8iaxrnpY7Gsy90F3q9nUlUUSp0M/rCDMmMhZmeU05Y9IcOYCX/z2RX
         cs+lkBtWU40Kzb/lUD5E6LIfHPyhvWV2G4P+qFYKqGTVhSYZe5m/H5MQu1mxqEhYjX
         V6QPMyrFHePAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01C7A5C0546; Sun,  9 Oct 2022 04:10:00 -0700 (PDT)
Date:   Sun, 9 Oct 2022 04:10:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs/memory-barriers.txt: Add a missed closing
 parenthesis
Message-ID: <20221009111000.GQ4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221008174928.13479-1-sj@kernel.org>
 <20221008174928.13479-2-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008174928.13479-2-sj@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 08, 2022 at 10:49:25AM -0700, SeongJae Park wrote:
> Description of io_stop_wc(), which added by commit d5624bb29f49
> ("asm-generic: introduce io_stop_wc() and add implementation for
> ARM64"), have unclosed parenthesis.  This commit closes it.
> 
> Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
> Signed-off-by: SeongJae Park <sj@kernel.org>

I have pulled this in, good eyes, and thank you!

On the other three, we have traditionally asked for an ack from a
Korean speaker.  Do we still feel the need to do this?

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 06f80e3785c5..cc621decd943 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1966,7 +1966,7 @@ There are some more advanced barrier functions:
>   (*) io_stop_wc();
>  
>       For memory accesses with write-combining attributes (e.g. those returned
> -     by ioremap_wc(), the CPU may wait for prior accesses to be merged with
> +     by ioremap_wc()), the CPU may wait for prior accesses to be merged with
>       subsequent ones. io_stop_wc() can be used to prevent the merging of
>       write-combining memory accesses before this macro with those after it when
>       such wait has performance implications.
> -- 
> 2.17.1
> 
