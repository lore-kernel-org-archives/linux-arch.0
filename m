Return-Path: <SRS0=948I=23=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDip (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 22:38:45 -0500
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com> <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
In-Reply-To: <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 6 Jan 2020 11:38:30 +0800
Message-ID: <CAJF2gTQ8-b2w7-v1giYN_UYcNMaeju8yv0ksUu2=g5YJtk1rdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Alan Kao <alankao@andestech.com>, linux-arch <linux-arch@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <ren_guo@c-sky.com>, Arnd Bergmann <arnd@arndb.de>, Atish Patra <atish.patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org, Vincent Chen <vincent.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Zong Li <zong.li@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, linux-riscv <linux-riscv@lists.infradead.org>, Bin Meng <bmeng.cn@gmail.com>
Message-ID: <20200106033830.3vdEpZ1EIEr0cQH_dqU1Rj7FLDD_KK1xkD706HMVlls@z>

Thx Anup,

The purpose of the patch is to talk about abi for linux & libc.

The most confused me is how max vlen (128/256/512/1024 ???), we should
put it into sigcontext. I need people's suggestions, thx.

Anyone help to review the patch are very helpful and we could
co-developed together, Thx

On Mon, Jan 6, 2020 at 11:00 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jan 6, 2020 at 8:15 AM Alan Kao <alankao@andestech.com> wrote:
> >
> > Hi Guo,
> >
> > On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > > 128bit-vlen and it's based on linux-5.5-rc4.
> > >
> >
> > According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
> > that "we plan to only accept patches for new modules or extensions that have
> > been frozen or ratified by the RISC-V Foundation."
> >
> > Is v0.8 ratified enough for now?
>
> As-per the patch acceptance policy, we cannot merge it now (just like KVM
> patches) but we can always review and get the patches in final shape
> by the time spec is frozen or ratified.
>
> I think we should continue with the patch review and get this series in
> good shape.
>
> In fact, having this patches early on LKML is very helpful for people working
> on RISC-V vector extension implementation in HW. On this line, this a good
> contribution coming at the right time.
>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
