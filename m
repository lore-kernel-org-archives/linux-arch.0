Return-Path: <SRS0=B83m=CX=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28726C43461
	for <linux-arch@archiver.kernel.org>; Mon, 14 Sep 2020 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08EF20829
	for <linux-arch@archiver.kernel.org>; Mon, 14 Sep 2020 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgm2P8lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgINKYT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgINKYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 06:24:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B9C06174A;
        Mon, 14 Sep 2020 03:24:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so22427038ejb.12;
        Mon, 14 Sep 2020 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV6D5Ck9gFOE7DCBMEmlAIDMaEEB8asrxDS/Nejj/VY=;
        b=Qgm2P8lXIs/sG42zI4dGYqmeeuImWwBegT9scXex3DjQYg1D+hgZGKMOWRoRqEz7pG
         sKvAKulF8YZPx5MXiU36nO2A3H4ku9B/rhHbVwUfkvSpDM+uI5dcOxb6LayzQNPQYgan
         3tcVCl2wWyb5oi7dKZCXHgEA6/7NUpBPDy4Jqn0xwqgbA89WLx2ZEj3tOqWlW7ZFIHeH
         Xn5Z30tBlNIhPn25AniCkxw14DjW2HuyYnzctb8L3gzPIG5eL7HfKhPIk3ZQzAQnoVaM
         J55P0EW3ru9M5Et00VM31+OUnYbvxshnaLd76jTJvDAFe8XgK4WpedOIPCc8v9hRrqBg
         78QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV6D5Ck9gFOE7DCBMEmlAIDMaEEB8asrxDS/Nejj/VY=;
        b=NiAWZk3jy5cO9dLYIA/wW5KvdU1bGHmZczgJnYBRLFP/B6owg884zez2N4SYQD1sOX
         7r936oVovNsCwAClif8ukLsg4I+8aFKerLNRpPzCWTHKcuB+72jKCBkiKjsHBjWAyhI2
         R6NnsLUswuKzGiKYm16cBpFBf1/6LDyDXtrUgOY9jKPfEUxta9kGtCyNmce8ztD8FpVd
         hCoatU7WX4jCf/TYnJisZRd04TLo87B0KV7fDjW99seTlY73bMmlZmXGXE3i1bWVqOUI
         nHc8kG7lJ1gMt43v+kSBlxRMnR28YOMnrC8/kAQiwwa0cIjFPHh8vsPI0roQhnIAmuwp
         IE9A==
X-Gm-Message-State: AOAM530r6Kjj6XwPwffAlLQqP1K9zyINwIkrj4qXjBxqA3OfxIkataRj
        qrnswBhodTHQUBaeSNb8yZj6E4AynVsLfq42YGE=
X-Google-Smtp-Source: ABdhPJxnBtRjr7WvcpNx4smmkuTpFTtnmeqe15JlsLaG07UR+6yM4//MyNOvunJKChDZKrrrN1vT1OGpv807OJjacRI=
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr13918816eja.59.1600079049351;
 Mon, 14 Sep 2020 03:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914045219.3736466-1-npiggin@gmail.com> <20200914045219.3736466-4-npiggin@gmail.com>
 <1600066040.vnmz9nxhwt.astroid@bobo.none>
In-Reply-To: <1600066040.vnmz9nxhwt.astroid@bobo.none>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 14 Sep 2020 13:23:58 +0300
Message-ID: <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 10:00 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:
>
> [...]
>
> > The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> > optimisation could be effectively restored by sending IPIs to mm_cpumask
> > members and having them remove themselves from mm_cpumask. This is more
> > tricky so I leave it as an exercise for someone with a sparc64 SMP.
> > powerpc has a (currently similarly broken) example.
>
> So this compiles and boots on qemu, but qemu does not support any
> sparc64 machines with SMP. Attempting some simple hacks doesn't get
> me far because openbios isn't populating an SMP device tree, which
> blows up everywhere.
>
> The patch is _relatively_ simple, hopefully it shouldn't explode, so
> it's probably ready for testing on real SMP hardware, if someone has
> a few cycles.

Nick,

applied this patch to over 'v5.9-rc5' tag , used my test VM (ldom)
with 32 vcpus.
Machine boot, stress-ng test ( run as
"stress-ng --cpu 8 --io 8 --vm 8 --vm-bytes 2G --fork 8 --timeout 15m" )
finishes without errors.
