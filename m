Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADBC00140
	for <linux-arch@archiver.kernel.org>; Fri, 29 Jul 2022 02:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiG2Ct1 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 28 Jul 2022 22:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiG2Ct0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 22:49:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA96A49C
        for <linux-arch@vger.kernel.org>; Thu, 28 Jul 2022 19:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 362EDB82674
        for <linux-arch@vger.kernel.org>; Fri, 29 Jul 2022 02:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0311C43140
        for <linux-arch@vger.kernel.org>; Fri, 29 Jul 2022 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659062962;
        bh=jRg2B+b/QYsWSWbEFkvnYAkGuz7fAf2rxdEDSoqQm5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F6CRznZk8gAgrallIVJAUrVfp31e/Tvv9iNcfbTk/3sxWMLX12lDg3+5DNFI8aCTs
         HKNo1j5/R2ldZro2uMh4PrzYjY9tPrK0d9lc054bsw2Gn73RwC0H8BXDwhj9pbiDgd
         dLBGmKIA8altp9uwTbvCuPB1ADhqeOjyTjdw1K9iu6sG16Tw8++fmXcaCUruDlGZEi
         dpyy/LY5rfRydKF/Sxpy9BesiwoVkcyozaWCdzFsjmOQOAPRug5I/L/4UNaDmbk0cP
         mffFbZJ5PPcVOuanR7UU9ira7eA67CQG+ZvN7xBMeAA1+7Pc8GmovGkg6ehS9h240t
         o/RO56hHp89jA==
Received: by mail-ua1-f45.google.com with SMTP id y22so1139348uay.1
        for <linux-arch@vger.kernel.org>; Thu, 28 Jul 2022 19:49:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo1Py2K5V9+t9CibAcrn8GtBowT2NFz1thz2iMP9Ho6aoR9LAgW+
        j67yMwvhLyWZOT3rDkt/w6Xpk2gQ42AoQilhHi0=
X-Google-Smtp-Source: AA6agR6D72gZNEBKAkx3FQoiJ9Pyg2GaD+0C1Q9wVVplvPDxCBp97VPsmFM6pBo5WBhVcss/Qnpd+Gm0U7mYlAjgWOU=
X-Received: by 2002:ab0:65d6:0:b0:385:f6e1:83ef with SMTP id
 n22-20020ab065d6000000b00385f6e183efmr596831uaq.23.1659062961741; Thu, 28 Jul
 2022 19:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220726130224.3987623-1-chenhuacai@loongson.cn> <06a332490e21353bcaf0678dc3f2f04e74bb3faf.camel@xry111.site>
In-Reply-To: <06a332490e21353bcaf0678dc3f2f04e74bb3faf.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 29 Jul 2022 10:49:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Qvn97oT9TDPKDWzdkctAAc=PWpAfBrGiGacH8T9z+VA@mail.gmail.com>
Message-ID: <CAAhV-H7Qvn97oT9TDPKDWzdkctAAc=PWpAfBrGiGacH8T9z+VA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Disable executable stack by default
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 29, 2022 at 10:28 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2022-07-26 at 21:02 +0800, Huacai Chen wrote:
> > Disable executable stack for LoongArch by default, as all modern
> > architectures do.
>
> Should this be a 5.19 fix?  IIUC after the first release we'll be
> impossible to change it because it would "break userspace".
>
> Note that 5.19 release is scheduled this weekend.
Already queued for 5.19-final, thanks.

Huacai
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/elf.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/elf.h
> > b/arch/loongarch/include/asm/elf.h
> > index f3960b18a90e..5f3ff4781fda 100644
> > --- a/arch/loongarch/include/asm/elf.h
> > +++ b/arch/loongarch/include/asm/elf.h
> > @@ -288,8 +288,6 @@ struct arch_elf_state {
> >         .interp_fp_abi = LOONGARCH_ABI_FP_ANY,  \
> >  }
> >
> > -#define elf_read_implies_exec(ex, exec_stk) (exec_stk ==
> > EXSTACK_DEFAULT)
> > -
> >  extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
> >                             bool is_interp, struct arch_elf_state
> > *state);
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
