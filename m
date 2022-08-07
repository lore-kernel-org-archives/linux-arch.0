Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0783FC19F2A
	for <linux-arch@archiver.kernel.org>; Sun,  7 Aug 2022 14:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiHGOug (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 7 Aug 2022 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiHGOug (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2022 10:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E46418;
        Sun,  7 Aug 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AwfVzm7jiZjpn8Qxl8YEy4z+Wq+bogYNtYxMRJ65KwM=; b=LyHMz+kclwkYVjF6uGwuPnsKnU
        BqV0xk1gaFnui5fO4kFxsNVTzkFqitlBp0e3I0Rdqu4XdQndJtiCpHtUMKCKnPieyBGTY6lH7vCt2
        VTJFbyH/DYyuEzUQ8z4Kk5tlOsugfBcNJtTg14l+Da1Alr8C8hzG3cJDCQdYAdE3jCeijQfaYwhwi
        54AI5BHp6JgMnZSlt6tYyKGA9IVp53oiQXZwlGp6BN8QtQE7Ujpq8GyIJqThLZD1h//y7ZcTsw90B
        p6i7mTVxbZ/U7B5+ZnE530cwmTGovtklZIG9HDdrNjU8vwwVloqjEwq94zWJJhPL1wxAYRq+zRg9X
        P1EOcWHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKhba-00D5Lb-Me; Sun, 07 Aug 2022 14:50:14 +0000
Date:   Sun, 7 Aug 2022 15:50:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] add barriers to buffer functions
Message-ID: <Yu/RJtoJPhkWXIdP@casper.infradead.org>
References: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <YuflGG60pHiXp2z/@casper.infradead.org>
 <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org>
 <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 07, 2022 at 07:37:22AM -0400, Mikulas Patocka wrote:
> @@ -135,6 +133,49 @@ BUFFER_FNS(Meta, meta)
>  BUFFER_FNS(Prio, prio)
>  BUFFER_FNS(Defer_Completion, defer_completion)
>  
> +static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
> +{
> +	/*
> +	 * make it consistent with folio_mark_uptodate
> +	 * pairs with smp_acquire__after_ctrl_dep in buffer_uptodate
> +	 */
> +	smp_wmb();
> +	set_bit(BH_Uptodate, &bh->b_state);
> +}
> +
> +static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
> +{
> +	clear_bit(BH_Uptodate, &bh->b_state);
> +}
> +
> +static __always_inline int buffer_uptodate(const struct buffer_head *bh)
> +{
> +	bool ret = test_bit(BH_Uptodate, &bh->b_state);
> +	/*
> +	 * make it consistent with folio_test_uptodate
> +	 * pairs with smp_wmb in set_buffer_uptodate
> +	 */
> +	if (ret)
> +		smp_acquire__after_ctrl_dep();
> +	return ret;
> +}

This all works for me.  While we have the experts paying attention,
would it be better to do

	return smp_load_acquire(&bh->b_state) & (1L << BH_Uptodate) > 0;

> +static __always_inline void set_buffer_locked(struct buffer_head *bh)
> +{
> +	set_bit(BH_Lock, &bh->b_state);
> +}
> +
> +static __always_inline int buffer_locked(const struct buffer_head *bh)
> +{
> +	bool ret = test_bit(BH_Lock, &bh->b_state);
> +	/*
> +	 * pairs with smp_mb__after_atomic in unlock_buffer
> +	 */
> +	if (!ret)
> +		smp_acquire__after_ctrl_dep();
> +	return ret;
> +}

Are there places that think that lock/unlock buffer implies a memory
barrier?
