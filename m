Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419DC433F5
	for <linux-arch@archiver.kernel.org>; Mon, 21 Mar 2022 08:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbiCUIsH (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345416AbiCUIr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 04:47:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA67A27CC;
        Mon, 21 Mar 2022 01:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BD21B81135;
        Mon, 21 Mar 2022 08:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8188C340F4;
        Mon, 21 Mar 2022 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647852391;
        bh=ncJjFwIzoe32DkMd8J7TFkIPBIC3KWEZV3tVyByKr5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RUYdzG6ttLqBh4mmoUuNFXtZiovyf8EL32Ifja5eb85KFi2+qcosC6Av44kg4SDTu
         ng4BF86lFaVajvu1E+/2JBQLCq1MTutjnoX3BblicXFtDFc72Mm+bgZ7fxMJIi5JBF
         vJWwu5sqNqTfEn1ELvoHGUGXvR7wc++jA2PmrlGTB/+FRTTWu4gAmjckJDMahkkv2H
         qfBjgHQlPyi2iTnBQ4c1KtMdwntNAZfLDLFVTYLa0stRTY1Xt51DbldbqOCzOnPicO
         2aCNAry1vKI/CNSHm15m9izd4HhpYzQ/zCt0bSc1P2GW/p8rRUEuprYVKi203TMErn
         NC1S3iG5kPCDQ==
Received: by mail-ua1-f45.google.com with SMTP id 34so5491859uao.13;
        Mon, 21 Mar 2022 01:46:31 -0700 (PDT)
X-Gm-Message-State: AOAM531YyDZ+FC1HgqxMEU1jHQeNiHnZaWOfOBYVbLMyXcVOSb1iLsmQ
        VGhjBmz0+iM7/r62aEtWzBMZPDyTFj9/W4kN3YI=
X-Google-Smtp-Source: ABdhPJy+xM/H9L9cr/krgDDPRDpEPe6mjR2ZF9aZeSj5hKVvobzISzwUAVg+tEIVTg2bgvk3wxDh1jfMbEeIMbiIQhc=
X-Received: by 2002:ab0:6544:0:b0:352:ec5d:b570 with SMTP id
 x4-20020ab06544000000b00352ec5db570mr6082359uap.96.1647852390724; Mon, 21 Mar
 2022 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-3-chenhuacai@loongson.cn>
 <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com>
In-Reply-To: <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 21 Mar 2022 16:46:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6eDSU20gjLgEKM318i1ksk23thv9cLJKmAo_cBzjtEkw@mail.gmail.com>
Message-ID: <CAAhV-H6eDSU20gjLgEKM318i1ksk23thv9cLJKmAo_cBzjtEkw@mail.gmail.com>
Subject: Re: [PATCH V8 10/22] LoongArch: Add exception/interrupt handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> > +unsigned long eentry;
> > +EXPORT_SYMBOL_GPL(eentry);
> > +unsigned long tlbrentry;
> > +EXPORT_SYMBOL_GPL(tlbrentry);
>
> Why are these exported to modules? Maybe add a comment here, or remove
> the export if it's not actually needed.
They are used by the kvm module in our internal repo.

Huacai
>
>        Arnd
