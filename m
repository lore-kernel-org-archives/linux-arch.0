Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E7C433E0
	for <linux-arch@archiver.kernel.org>; Wed, 13 Jan 2021 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2832339F
	for <linux-arch@archiver.kernel.org>; Wed, 13 Jan 2021 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAMPNI (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbhAMPNI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 10:13:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD79F2333E;
        Wed, 13 Jan 2021 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610550746;
        bh=sY6LSpADNTXFnYKZ4zGIS9mQHZ3VCv/mrboz1GvoHBI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tfA9ExzxTVn1GDm/tUWmbU8PVo26QiJRTFUNWxcFPOqRMETUDPUDdC8I9qbobIGnA
         xjT7wMBtgMpwZOOhxbsjn6o7ehLpThtOyo4N0hpLilfNY4DB6wkxY9mU41B/g8uW/J
         hc5E4HaH3SUFMjNg41U3YswMb/iToI97YpCIyLyXwfHix9M7SAU0B6fX7MLbZJbCin
         xZ9SnbjPc3FH6/aGsRFZmfKJaMbmvKMOUWxnrVAJnleFHQjRkY4xCAO7rjXjMyKTXG
         XyfO1iqJ2Mb45aeHjUoVx9ep2ZVqD/XtlNBpOLHQi2nRLWxoL4Okzf/BMMlrw7yh+5
         KgVYgycKHaQ2w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8C4A435225BD; Wed, 13 Jan 2021 07:12:26 -0800 (PST)
Date:   Wed, 13 Jan 2021 07:12:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/24] doc: update rcu_dereference.rst reference
Message-ID: <20210113151226.GS2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <e2293b68eefdd00ea0f4795bc0672ef70f8627e2.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2293b68eefdd00ea0f4795bc0672ef70f8627e2.1610535350.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 13, 2021 at 11:59:20AM +0100, Mauro Carvalho Chehab wrote:
> Changeset b00aedf978aa ("doc: Convert to rcu_dereference.txt to rcu_dereference.rst")
> renamed: Documentation/RCU/rcu_dereference.txt
> to: Documentation/RCU/rcu_dereference.rst.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Queued, thank you!

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/glossary.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> index b2da6365be63..6f3d16dbf467 100644
> --- a/tools/memory-model/Documentation/glossary.txt
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -19,7 +19,7 @@ Address Dependency:  When the address of a later memory access is computed
>  	 from the value returned by the rcu_dereference() on line 2, the
>  	 address dependency extends from that rcu_dereference() to that
>  	 "p->a".  In rare cases, optimizing compilers can destroy address
> -	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
> +	 dependencies.	Please see Documentation/RCU/rcu_dereference.rst
>  	 for more information.
>  
>  	 See also "Control Dependency" and "Data Dependency".
> -- 
> 2.29.2
> 
