Return-Path: <SRS0=R2lO=CO=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F4C43461
	for <linux-arch@archiver.kernel.org>; Sat,  5 Sep 2020 07:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9DF20760
	for <linux-arch@archiver.kernel.org>; Sat,  5 Sep 2020 07:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIEHOw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:14:52 -0400
Received: from verein.lst.de ([213.95.11.211]:43936 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Sep 2020 03:14:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1F6568BEB; Sat,  5 Sep 2020 09:14:47 +0200 (CEST)
Date:   Sat, 5 Sep 2020 09:14:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from,to}_user
Message-ID: <20200905071447.GA13228@lst.de>
References: <20200904165216.1799796-1-hch@lst.de> <20200904165216.1799796-4-hch@lst.de> <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 08:04:34PM +0200, Arnd Bergmann wrote:
> >         if (__builtin_constant_p(n)) {
> >                 switch(n) {
> >                 case 1:
> > -                       *(u8 *)to = *(u8 __force *)from;
> > +                       *(u8 *)to = get_unaligned((u8 __force *)from);
> >                         return 0;
> >                 case 2:
> > -                       *(u16 *)to = *(u16 __force *)from;
> > +                       *(u16 *)to = get_unaligned((u16 __force *)from);
> >                         return 0;
> 
> The change look correct and necessary, but I wonder if this could be done
> in a way that is a little easier on the compiler than the nested switch/case.
> 
> If I see it right, __put_user() and __get_user() can probably
> be reduced to a plain put_unaligned() and get_unaligned() here,
> which would simplify these a lot.
> 
> In turn it seems that the generic raw_copy_to_user() can just be the
> a plain memcpy(), IIRC the optimization for small sizes should also
> be done by modern compilers whenever they can.

Sure, I can look into that.
