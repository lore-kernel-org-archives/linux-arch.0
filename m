Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6528C4332F
	for <linux-arch@archiver.kernel.org>; Tue, 22 Nov 2022 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiKVBpY (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiKVBpY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 20:45:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477F5C607D;
        Mon, 21 Nov 2022 17:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03580B818C0;
        Tue, 22 Nov 2022 01:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E7C433C1;
        Tue, 22 Nov 2022 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669081519;
        bh=z34DajHD7W/rVo1ud+gpXtouzR1ikFLBJZP4d+GM5CY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ongL2fmiLCiLoXIajx1DuIsXUZ1Eir8gxQQrl3l9UxV/2nPfo43nXD5/LPfBUNS6k
         AOKXA8zUbRX83h2+WdZPw0+Z5uXTWPosuA4/jaHfAeyLpKb0w157GVfa+FcGsmxBNW
         F4ufHsnJg2Tg3Wa37ue617cDRxneyBcX0DcV6WHvjOUrRiWz+4Cy0K3x4cyII3EUTO
         lcVyxcNkNXZO+2DPbB7BTs2RG+MMkIB5OzKNjTv6KmwgsgQhd2FA9+0yOG3wH/kpm8
         U06fy6LVuJVo8sNzdcdGUzr5oXxCbb4Z8CLIxb6i/7eVNc67259PjCWhTwWDVeU9xx
         ZcqjOMf42ndmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 30FA05C0641; Mon, 21 Nov 2022 17:45:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:45:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/memory-model: Use "grep -E" instead of "egrep"
Message-ID: <20221122014519.GZ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1669001138-12302-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669001138-12302-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 11:25:38AM +0800, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/memory-model`
> 
> Here are the steps to install the latest grep:
> 
>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>   tar xf grep-3.8.tar.gz
>   cd grep-3.8 && ./configure && make
>   sudo make install
>   export PATH=/usr/local/bin:$PATH
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Queued and pushed, thank you both!

							Thanx, Paul

> ---
> 
> v2: rebase on linux-rcu.git dev
> 
>  tools/memory-model/scripts/checkghlitmus.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
> index cedd029..d3dfb32 100755
> --- a/tools/memory-model/scripts/checkghlitmus.sh
> +++ b/tools/memory-model/scripts/checkghlitmus.sh
> @@ -36,13 +36,13 @@ fi
>  # Create a list of the specified litmus tests previously run.
>  ( cd $LKMM_DESTDIR; find litmus -name "*.litmus${hwfnseg}.out" -print ) |
>  	sed -e "s/${hwfnseg}"'\.out$//' |
> -	xargs -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
> +	xargs -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
>  	xargs -r grep -L "^P${LKMM_PROCS}"> $T/list-C-already
>  
>  # Create a list of C-language litmus tests with "Result:" commands and
>  # no more than the specified number of processes.
>  find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
> -xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
> +xargs < $T/list-C -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
>  xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
>  
>  # Form list of tests without corresponding .out files
> -- 
> 2.1.0
> 
