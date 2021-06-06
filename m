Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3AC47096
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE1461287
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 15:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFPnv (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 6 Jun 2021 11:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhFFPnv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 11:43:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7B0A6141E;
        Sun,  6 Jun 2021 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622994121;
        bh=UALv1P9ICCpdZuB9WXtufq8mFK4k0gfcSTsGNuUHdbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N9rfx5WEM01sc2oMICMR3LxHqzPwHxVD3X8RaCYGAz2aqJLvnGQKEjWlwIcAJ90vP
         FSyE+y4lcqtA2TIifHh6qG0g8ALpoHwdJfdFDcAoVhN6GURA2sAnCYO9UNbxvVB2RF
         CU2fMPGiGHcj6x0NfT7qT8+UqkfQ+nhrCTFOvdM8XKjXlDergtr9cmR/bQvMxgIhkk
         5ach0+jzOFf412AgFUHq0QcsDzu/AP8R/P6BV0Y9REFYKd46o+DIizQfbGlg43aBVQ
         W0uT8riRypy0LfiJrCdqNWH3Cojpd96xA7ZlZZ0IfKo6JIveUoo+bNCNJuwPa7nTWT
         vr1Minc11imBg==
Received: by mail-lj1-f175.google.com with SMTP id d2so14310010ljj.11;
        Sun, 06 Jun 2021 08:42:01 -0700 (PDT)
X-Gm-Message-State: AOAM53020T8PVnMSPbH767qlEwgHUrtMdpIa1SRyr9VL93u8pBOGhdGU
        mgDuSd3udLdgBtU4mLMIzr4tp0xO1CLRzU6Pma0=
X-Google-Smtp-Source: ABdhPJz/ymuruvAxsVBO3eBrDTvU5oqkJkvuhWlYn5kOpMHnRZRI9xA7WGJSBhIVrhRZH65ESpGQlHUhEJNlEggaNUM=
X-Received: by 2002:a2e:8e90:: with SMTP id z16mr11137106ljk.508.1622994120228;
 Sun, 06 Jun 2021 08:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <20210606115027.5c715e64@slackpad.fritz.box> <CAJF2gTQgaJFW9knuVmW8J8zMAt_Gtq3KJ9gsGKg6=xLBuq0=uA@mail.gmail.com>
 <49182865.cm8dGOVcTj@jernej-laptop>
In-Reply-To: <49182865.cm8dGOVcTj@jernej-laptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 6 Jun 2021 23:41:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR3nUYsFv5=29DbE=nrgDaqmcj3KRm8F-WKsdTXHX02sQ@mail.gmail.com>
Message-ID: <CAJF2gTR3nUYsFv5=29DbE=nrgDaqmcj3KRm8F-WKsdTXHX02sQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only
 for temp use
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 6, 2021 at 11:39 PM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Hi!
>
> Dne nedelja, 06. junij 2021 ob 17:32:22 CEST je Guo Ren napisal(a):
> >  ,
> >
> > On Sun, Jun 6, 2021 at 6:50 PM Andre Przywara <andre.przywara@arm.com>
> wrote:
> > > On Sun,  6 Jun 2021 09:04:09 +0000
> > > guoren@kernel.org wrote:
> > >
> > > Hi,
> > >
> > > > From: liush <liush@allwinnertech.com>
> > > >
> > > > This is a temporary driver, only guaranteed to work on allwinner
> > > > D1. In order to ensure the developer's demand for network usage.
> > >
> > > That looks like some Allwinner BSP driver, please don't endorse code
> > > of this quality (just look at all that commented code and the attempt
> > > for compile-time configuration).
> > >
> > > > It only could work at 1Gps mode.
> > > >
> > > > The correct gmac driver should follow (I guess)
> > > > drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > >
> > > > If anyone is familiar with it and can help porting, I would be
> > > > very grateful.
> > >
> > > Have you tried compiling and using that driver? Ideally it should jus=
t
> > > work, Linux drivers are meant to be portable, by design. And the driv=
er
> > > is already enabled by COMPILE_TEST.
> >
> > It still needs some work with dwmac-sun8i.c glue layer, eg:
> > tx/rx-delay setting, clk & pinmux drivers.
> >
> > The patch is just to help people using D1 with GMAC temporarily with
> > network function.
>
> It should be marked "DO NOT MERGE" or similar then.
Yes, thx for reminding. I'll fix it next time.

>
> Best regards,
> Jernej
>
> >
> > > But I guess you need some extra care to make the non-coherent DMA wor=
k?
> > > I haven't looked in detail, but are those new CMOs hooked into the
> > > generic DMA framework?
> >
> > Yes, we have the simliar principle with arm & csky for non-coherent:
> >  - Using PTE attributes setting Using PTE attributes to support
> > _PAGE_IOREMAP & _PAGE_WRITECOMBINE
> >  - Using CMO instructions deal SYNC_DMA_FOR_CPU/DEVICE.
> >
> > > Cheers,
> > > Andre
> > >
> > > > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > > > Tested-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Corentin Labbe <clabbe@baylibre.com>
> > > > Cc: Samuel Holland <samuel@sholland.org>
> > > > Cc: Icenowy Zheng <icenowy@aosc.io>
> > > > Cc: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > > Cc: Michael Walle <michael@walle.cc>
> > > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > > Cc: Maxime Ripard <maxime@cerno.tech>
> > > > Cc: Wei Fu <wefu@redhat.com>
> > > > Cc: Wei Wu <lazyparser@gmail.com>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
