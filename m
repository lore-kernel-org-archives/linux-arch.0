Return-Path: <SRS0=rKsc=43=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38151 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJJTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2020 05:19:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so6053546qke.5
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2020 02:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200308094954.13258-1-guoren@kernel.org> <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
 <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com> <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
In-Reply-To: <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
From: Greentime Hu <greentime.hu@sifive.com>
Date: Tue, 10 Mar 2020 17:19:36 +0800
Message-ID: <CAHCEehLq5f+DGusL0T4ZUuJ2hTRhSyLSGRpKHhq5b4J3nXfBHg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Cc: guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200310091936.JsO4trXbpK0mFlVriFY_4D2YkUSi-gB8lE1N8PJr_6M@z>

On Tue, Mar 10, 2020 at 4:54 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> On Mon, Mar 9, 2020 at 6:27 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> > On 2020/3/9 11:41, Greentime Hu wrote:
> > > On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
> > >> From: Guo Ren <guoren@linux.alibaba.com>
> > >>
> > >> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > >> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
> > >>
> > >> The patch implement basic context switch, sigcontext save/restore and
> > >> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> > >> is implemented. We need to discuss about vlen-size for libc sigcontext and
> > >> ptrace (the maximum size of vlen is unlimited in spec).
> > >>
> > >> Puzzle:
> > >> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> > >> before, and riscv also met vlen size problem. Let's discuss the common issue
> > >> for all architectures and we need a better solution for unlimited vlen.
> > >>
> > >> Any help are welcomed :)
> > >>
> > >>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> > > Hi Guo,
> > >
> > > Thanks for your patch.
> > > It seems the qemu repo doesn't have this branch?
> > Hi Greentime,
> >
> > It's a promise from me. Now it's ready.  You can turn on vector by
> > "qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".
> >
> > Zhiwei
> >
> >
>
> Hi Zhiwei,
>
> Thank you, I see the branch in the repo now. I will give it a try and
> let you know if I have any problem. :)

Hi Zhiwei & Guo,

It seems current version only support v0.7.1 in qemu but this patchset
is verified in qemu too and it is based on 0.8.
Would you please provide the qemu with 0.8 vector spec supported? or
Did I miss something?

489             if (cpu->cfg.vext_spec) {
490                 if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
491                     vext_version = VEXT_VERSION_0_07_1;
492                 } else {
493                     error_setg(errp,
494                            "Unsupported vector spec version '%s'",
495                            cpu->cfg.vext_spec);
496                     return;
497                 }
498             }

By the way, can I specify vlen in Qemu?
Thank you. :)
