Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADCAC64E7A
	for <linux-arch@archiver.kernel.org>; Thu,  3 Dec 2020 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC8E206B6
	for <linux-arch@archiver.kernel.org>; Thu,  3 Dec 2020 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgLCMcU (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLCMcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 07:32:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F893C061A4F;
        Thu,  3 Dec 2020 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2bjAG/22Xb88hJcxvz1EpCKJuf3oMonmSEWRI/Pfre8=; b=kN0UfyVg5AFOJTIput+Nt86Ekc
        Q3LG5weU1QXDniBRaUvnMsL7gDgKEdCY5djySEvEofodaN1oOJzQyhc1Kf2/yO4W0VNfTEksLApbT
        A7Zi3WkZDAXP4ejREwrP3JYM18d0SnEFU/HmbURuGmvuY6Oezfkiz1aIsxY0nHJGzo5KPTCSHarUI
        u3Yj4gaRjHW1Br4I8C/SIXsIstOJ5pyAIpUodg1RBA7oTCEEJdBXkfai7rjojy37PucTs0pEh6BEr
        Z4KFyjpIxNUiC+YtkWgZ9KwSFPTGRMAm4wn2reffMSzX/xrfLSVu656ADBhfEBiUC3U7LtZHRMja2
        3DiMaunw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kknlh-0007Ex-HX; Thu, 03 Dec 2020 12:31:29 +0000
Date:   Thu, 3 Dec 2020 12:31:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
Message-ID: <20201203123129.GH11935@casper.infradead.org>
References: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 09:25:51PM -0800, Andy Lutomirski wrote:
> This code compiles, but I haven't even tried to boot it.  The earlier
> part of the series isn't terribly interesting -- it's a handful of
> cleanups that remove all reads of ->active_mm from arch/x86.  I've
> been meaning to do that for a while, and now I did it.  But, with
> that done, I think we can move to a totally different lazy mm refcounting
> model.

I went back and read Documentation/vm/active_mm.rst recently.

I think it's useful to think about how this would have been handled if
we'd had RCU at the time.  Particularly:

Linus wrote:
> To support all that, the "struct mm_struct" now has two counters: a
> "mm_users" counter that is how many "real address space users" there are,
> and a "mm_count" counter that is the number of "lazy" users (ie anonymous
> users) plus one if there are any real users.

And this just makes me think RCU freeing of mm_struct.  I'm sure it's
more complicated than that (then, or now), but if an anonymous process
is borrowing a freed mm, and the mm is freed by RCU then it will not go
away until the task context switches.  When we context switch back to
the anon task, it'll borrow some other task's MM and won't even notice
that the MM it was using has gone away.
