Return-Path: <SRS0=2s9f=B2=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF1C433E1
	for <linux-arch@archiver.kernel.org>; Sun, 16 Aug 2020 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25862207FB
	for <linux-arch@archiver.kernel.org>; Sun, 16 Aug 2020 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fb3+potx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgHPMxl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgHPMxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 08:53:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B20C061786;
        Sun, 16 Aug 2020 05:53:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BTxtk1wzYz9sTR;
        Sun, 16 Aug 2020 22:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1597582414;
        bh=xpLVIzLpo/1ZhQwWcKA7c8rb6SmsBOgSF5mqM7GHsWY=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=fb3+potxlS9NiACHDhstC8E0WATgvYJ9izglTZ2GSFNu31rYjqsHvMT3VxJ9fg6Od
         twnwYvGCoKrRjF7zJRv+8DnUIRRdHeBBq8NH+WFZ1q2oo8X6YmAmhM8rp6Ku5RSf9q
         HuktcBiE54nMDMbmWUpdYcah3fBc5THqFOJ0H77+s2WA2YKyTfQvbeT1z95WeSw58l
         brk3dL0BwZFiwYF58Cq08Mb1RLxfYAUOni1AlzkVVvSideVn8Qdn6kQP9Mo87oeOJm
         BNFEA037TPSBKGrvSeK5CpfSMa6c/xRWS7KYVHk9eqgVIVErt50sFLkjQaaygClnOW
         OjOMo8L55u9gg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TECH TOPIC] Planning code obsolescence
In-Reply-To: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Date:   Sun, 16 Aug 2020 22:53:29 +1000
Message-ID: <874kp2ah12.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> I have submitted the below as a topic for the linux/arch/* MC that Mike
> and I run, but I suppose it also makes sense to discuss it on the
> ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> even if we don't discuss it at the main ksummit track.
>
>      Arnd
>
> 8<---
...
>
> I propose adding a Documentation file that keeps track of any notable
> kernel feature that could be classified as "obsolete", and listing
> e.g. following properties:
>
> * Kconfig symbol controlling the feature
>
> * How long we expect to keep it as a minimum
>
> * Known use cases, or other reasons this needs to stay
>
> * Latest kernel in which it was known to have worked
>
> * Contact information for known users (mailing list, personal email)
>
> * Other features that may depend on this
>
> * Possible benefits of eventually removing it
>
> With that information, my hope is that it becomes easier to plan when
> some code can be removed after the last users have stopped upgrading
> their kernels, while also preventing code from being removed that is
> actually still in active use.
>
> In the discussion at the linux/arch/* MC, I would hope to answer these
> questions:
>
> * Do other developers find this useful to have?

Yes!

> * Where should the information be kept (Documentation/*, Kconfig,
> MAINTAINERS, wiki.kernel.org, ...)

Documentation/ seems like the obvious place. Possibly also somewhere on
wiki.kernel.org or elsewhere so that people can contribute information
without having to submit a formal patch.

> * Which information should be part of an entry?

Your list above is pretty good.

For features that relate to specific hardware I think it would be useful
to have some more information.

For example when the hardware was last manufactured, who made it, how
could it be purchased when it was available (eg. was it for sale to the
public or in limited quantities or only to certain people or internal to
a particular company).


> * What granularity should this be applied to -- only high-level features
> like CPU architectures and subsystems, or individual drivers and machines?

I think it can make sense at many levels. It probably just depends on
how much effort folks want to go to in order to track down the
information.

Looking at powerpc it would be useful to have that sort of info for
individual boards, as well as each platform, CPU families and specific
drivers.

cheers
