Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3260C433FE
	for <linux-arch@archiver.kernel.org>; Tue,  8 Dec 2020 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5454923A5A
	for <linux-arch@archiver.kernel.org>; Tue,  8 Dec 2020 10:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgLHKgf (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgLHKgf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 05:36:35 -0500
Date:   Tue, 8 Dec 2020 10:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607423754;
        bh=ffXh/ffsFEu14yYkVpY1W+3Tb6JWOvb9jWcp7gmAz2g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jv1ty0fx2BX6Qj72fdbIYdZax8z6degjujXihkSyIV3UDb97UyieX87rWb9JnOawd
         pXhwuacdG+oxlOhtVN1nycBQGosStF8DwNj07kppxrJ/n2SKKvQORxiMA19Mb+xBJs
         xz71tgAnVkOVazSgi0d+kxvDN5kC6lqWXpiBAtVnBZmobANuUmpOrTEtMaANVSB3PQ
         gwZO1zItEGR8VUcUdPpVyXosXmXS7/zzf5wYI64aJrLaJl0Qf6RG0/jONM3jY+8OW7
         Y0oeCYv2buhqif9br8mchpVwsELCVxhQigueqioBdr8BhNLL7Na0L7A9OlPMlJqJSq
         KfGD6MFcN2qew==
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH] arm64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20201208103549.GA5887@willie-the-truck>
References: <20201205165406.108990-1-yury.norov@gmail.com>
 <20201207112530.GB4379@willie-the-truck>
 <CAAH8bW-fb0wPwwvo8P8VW33zV=Wi_LPWxdJH8y2wdGGqPE+3nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-fb0wPwwvo8P8VW33zV=Wi_LPWxdJH8y2wdGGqPE+3nA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 07, 2020 at 05:59:16PM -0800, Yury Norov wrote:
> (CC: Alexey Klimov)
> 
> On Mon, Dec 7, 2020 at 3:25 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Sat, Dec 05, 2020 at 08:54:06AM -0800, Yury Norov wrote:
> > > ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> > > enable it in config. It leads to using find_next_bit() which is less
> > > efficient:
> >
> > [...]
> >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 1515f6f153a0..2b90ef1f548e 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -106,6 +106,7 @@ config ARM64
> > >       select GENERIC_CPU_AUTOPROBE
> > >       select GENERIC_CPU_VULNERABILITIES
> > >       select GENERIC_EARLY_IOREMAP
> > > +     select GENERIC_FIND_FIRST_BIT
> >
> > Does this actually make any measurable difference? The disassembly with
> > or without this is _very_ similar for me (clang 11).
> >
> > Will
> 
> On A-53 find_first_bit() is almost twice faster than find_next_bit(),
> according to
> lib/find_bit_benchmark. (Thanks to Alexey for testing.)

I guess it's more compiler dependent than anything else, and it's a pity
that find_next_bit() isn't implemented in terms of the generic
find_first_bit() tbh, but if the numbers are as you suggest then I don't
have a problem selecting this on arm64.

Will
