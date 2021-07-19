Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863BC07E9B
	for <linux-arch@archiver.kernel.org>; Mon, 19 Jul 2021 13:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53289610A5
	for <linux-arch@archiver.kernel.org>; Mon, 19 Jul 2021 13:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhGSMVm (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbhGSMVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jul 2021 08:21:42 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD8C061574
        for <linux-arch@vger.kernel.org>; Mon, 19 Jul 2021 05:21:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p186so19795307iod.13
        for <linux-arch@vger.kernel.org>; Mon, 19 Jul 2021 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XT1rftsceASPZek6TfqeMDtP7+haDAJIWhlgNtS1qc=;
        b=D1wxlC/fE0F7kmOoJFyEHcAVDiPTB4aRYPRq1H3VteimxycDsaZ8JEjmAQQSnwLbIj
         MlgoDmx+IAGuVql/1cOj7wc+G2F3+RGHFQx8sMbgKn/Z81BAjmobAhNFHYWg1psh9pwY
         2LTr7n09/1EPHC/ZR8TFK7ORegZ3lgkFI90vdgkn3rmIXJXGlIvzSC6KA/uIRUydQX2s
         oKqly5lrzHiNfw/WLzvhFvYY380+uyIAAz26oaihcnAnz//yqezUMf1+gXZrnhKd6ZIS
         a2Eh2N8VC9yOIiSGP0FJipXphUHgR3gNviQFWwSbNFYQ+qiySStFIvm298V/KHqfGA4c
         nfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XT1rftsceASPZek6TfqeMDtP7+haDAJIWhlgNtS1qc=;
        b=eX77ox+tIXZpuY+BIWsHWUcPzhyZKeTtsy7dD3L8FeB7mTG/cL43p5935h8AhXrn1x
         HyhfEQXrwJSFMOhelbA80OSOsn3WN4TNtZhIZXRQ/Y0fJxsfRfSCMlLrDmXqDPIXbyCK
         j20yq3yt4UTawGP1xoUdpmVXGU2nf3fNK9gFR9PCqzKLDAsTRplDV+iH5RHjrAGM7Tk1
         lJMDGYlSiB7WEsCxZd6k8q5WcdT+KevMyw07WOkkZFe04eqzMleeFq48HW3AQkENKAh8
         PxC6TKg8loBAe+P6mOunW9CAzI+85nMibIjwJgm9iFuDkjLhVI+rGyvNrD8l/EwbluoG
         IH0A==
X-Gm-Message-State: AOAM5301jsVSA/KCZZouM1zKSD6XYYuS49R7hIou7zzvAQzY86zY9m1F
        4r/g4yjuJoS18fjCXtEWkwJ4B1q5p4+T5tB//cE=
X-Google-Smtp-Source: ABdhPJxHNUOjQBYiGRdpqFS1fo8rR3YVf6XI/cn87Zq7ez2iot8DDQaJNNH+uzS0++uE1gWOpN0GBNQeHTMRY6471jQ=
X-Received: by 2002:a05:6602:2406:: with SMTP id s6mr13611406ioa.159.1626699740927;
 Mon, 19 Jul 2021 06:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-4-chenhuacai@loongson.cn> <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
 <CAAhV-H796UQNaRkiaJhYRHsO-36KE_5d6sT=sJaKXCKfHtP-Mg@mail.gmail.com> <CAK8P3a1kX_wHz_BpdD=pB-Fd2Cy3_xDvTsRKVvKR+_9GP0NSmA@mail.gmail.com>
In-Reply-To: <CAK8P3a1kX_wHz_BpdD=pB-Fd2Cy3_xDvTsRKVvKR+_9GP0NSmA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 19 Jul 2021 21:02:10 +0800
Message-ID: <CAAhV-H4iBVTbJPagY3btFrAmwNgqqrYDAY6oMoE-1gb21Jpptg@mail.gmail.com>
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Jul 19, 2021 at 3:43 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Jul 19, 2021 at 3:26 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >  Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/Kbuild
> > > > @@ -0,0 +1,21 @@
> > > > +# Fail on warnings - also for files referenced in subdirs
> > > > +# -Werror can be disabled for specific files using:
> > > > +# CFLAGS_<file.o> := -Wno-error
> > > > +ifeq ($(W),)
> > > > +subdir-ccflags-y := -Werror
> > > > +endif
> > >
> > > This tends to break building with 'make W=12' or similar, I would recommend not
> > > adding -Werror. It is a good idea though to have your CI systems build
> > > with -Werror
> > > enabled on the command line though.
> > If we use W=???, corresponding flags will be used; if we don't use
> > W=???, -Werrer flag is used here. So it seems not break the building.
>
> The thing is that we get three new compiler releases every year, one gcc
> and two llvm. Usually every release introduces new warnings, so even if
> you quickly address those in mainline kernels, anyone using an older kernel
> will find themselves unable to build it with a newer compiler.
OK, I know.

>
> > > > +       select ARCH_MIGHT_HAVE_PC_PARPORT
> > > > +       select ARCH_MIGHT_HAVE_PC_SERIO
> > > > +       select GENERIC_ISA_DMA
> > > > +       select ISA
> > >
> > > Do you actually have ISA-style add-on cards? If not, then
> > > remove the ISA options. If you do, which drivers are they?
> > Yes, there is an LPC controller in LS7A, and superio is connected on
> > it for laptops.
>
> CONFIG_ISA only refers to actual 16-bit add-on cards, not LPC
> style on-board devices. Sometimes the options are used inconsistently,
> but unless you need an original Soundblaster or NE2000 card, this
> should not be needed. Note that some older x86-64 and arm64 have
> LPC as well, but do not support CONFIG_ISA.
>
> For GENERIC_ISA_DMA, I suppose that could be used for the parallel
> port driver, but even if you have one of those, it might be easier to leave
> it out and just no longer support Zip drives or dot matrix printers attached
> to them.
>
> ARCH_MIGHT_HAVE_PC_SERIO is probably needed if this is how
> you attach your keyboard and trackball, but it should work without the
> others.
OK, I'll remove ISA and GENERIC_ISA_DMA.

Huacai
>
>        Arnd
