Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0EC07E96
	for <linux-arch@archiver.kernel.org>; Tue,  6 Jul 2021 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2B5620DC
	for <linux-arch@archiver.kernel.org>; Tue,  6 Jul 2021 12:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhGFMFh (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237142AbhGFLf5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:35:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C8ED61CC3
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570743;
        bh=NMv1p7GNORLOIb0kQ+W5gY4yPE7n7BoPYBjrqQwuwck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nnqX9nJpa3TJ7q2f3P1Jf2mMl+RNSjWwe2dvbujwRd+wyL52ZCAGLMkqeNTHD3/gs
         q/2Cm4OOsbKcWfe0Hxp9C6o0nsvz3+U4EWuEng3x8u/SMbxaVWuQ1Saa7DuRZ62Yy8
         /4sQKeCOW9sDLfnUiq9mqROo65C8TvxMnAU9iH/ZmGsF9ln8q+ncZFw8iDPQ6FgTAz
         MIUDFTkjM1BgWlo7j9mr4FBJSPNjV4aEfbkmP5kbQb3rJbnYAt17/t4X/IylzineMo
         985mzvQ2MkHbySD3jd7/MK2i5RHeqomQBwwcXa0o2Bcbeg21mlMcub4ybgfIUVTVPB
         Ob2BHotSLzovA==
Received: by mail-wm1-f54.google.com with SMTP id j34so13303196wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:25:43 -0700 (PDT)
X-Gm-Message-State: AOAM530vZpnLxeaj3wDVlrb2Nrw5C6aiYq1te4tLaIuj/oy7QEbyvJ6w
        LZtEDlWeAmAbAWzpmU6bfzHJJoRrIkRxO1+MT40=
X-Google-Smtp-Source: ABdhPJw+3FtSynYnJGuSEZt6aCd17GeHOnQEnp/Dn+R4qP7dDbpZKK+ItcabATZBODUCtppZycBiSSuZkR2IRVESEXA=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4149832wmb.142.1625569051717;
 Tue, 06 Jul 2021 03:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-8-chenhuacai@loongson.cn> <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
In-Reply-To: <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:57:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Q+vPhWZRSUs4jSZuX-mryHpPgQBgzjHQogjKh-X_TmQ@mail.gmail.com>
Message-ID: <CAK8P3a2Q+vPhWZRSUs4jSZuX-mryHpPgQBgzjHQogjKh-X_TmQ@mail.gmail.com>
Subject: Re: [PATCH 07/19] LoongArch: Add process management
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +void arch_cpu_idle(void)
> +{
> +       local_irq_enable();
> +       __arch_cpu_idle();
> +}

This looks racy: What happens if an interrupt is pending and hits before
entering __arch_cpu_idle()?

Usually CPU idle instructions are designed to be called with interrupts disabled
and wait until an interrupt happens, including one that was already pending.

           Arnd
