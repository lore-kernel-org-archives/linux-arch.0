Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfHXAye (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 20:54:34 -0400
MIME-Version: 1.0
References: <cover.1566540652.git.han_mao@c-sky.com> <820d80272fc5627b8d00e684663a614470217606.1566540652.git.han_mao@c-sky.com>
 <CAEbi=3fbe9zbsLyfA=s9gHtAFJrp5Ox0jWoAqcZudQ_xODicgA@mail.gmail.com>
In-Reply-To: <CAEbi=3fbe9zbsLyfA=s9gHtAFJrp5Ox0jWoAqcZudQ_xODicgA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 24 Aug 2019 08:54:20 +0800
Message-ID: <CAJF2gTS80XU=4z-_=N=oGV6GH-+8KXCa74DyhVMcRxJRBq5g4A@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] riscv: Add perf callchain support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Mao Han <han_mao@c-sky.com>, linux-riscv@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@lst.de>
Message-ID: <20190824005420.z_uDNPGOVwKkv8-ZD7ZZxc6rHWdJyHfDtlQgleW9ixg@z>

Please check CONFIG_FRAME_POINTER

1 *frame =3D *((struct stackframe *)frame->fp - 1);
This code is origionally from riscv/kernel/stacktrace.c: walk_stackframe

In linux/Makefile it'll involve the options for gcc to definitely
store ra & prev_fp in fp pointer.
ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS +=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls

So --call-graph fp need depends on CONFIG_FRAME_POINTER.

On Fri, Aug 23, 2019 at 4:56 PM Greentime Hu <green.hu@gmail.com> wrote:
>
> Hi Mao,
>
> Mao Han <han_mao@c-sky.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8823=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> >
> > This patch add support for perf callchain sampling on riscv platform.
> > The return address of leaf function is retrieved from pt_regs as
> > it is not saved in the outmost frame.
> >
> > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: linux-riscv <linux-riscv@lists.infradead.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Makefile                |   3 +
> >  arch/riscv/kernel/Makefile         |   3 +-
> >  arch/riscv/kernel/perf_callchain.c | 115 +++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 120 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/kernel/perf_callchain.c
>
> I just tested "./perf record -e cpu-clock --call-graph fp ls" on
> Unleashed board and I got this failure.
> I take a look at it. It seem failed in here. Do you have any idea?
> It seems fine in Qemu.
>
> 1 *frame =3D *((struct stackframe *)frame->fp - 1);
> ffffffe0001a198c: 00863a83 ld s5,8(a2)
> ffffffe0001a1990: ff093903 ld s2,-16(s2)
>
> ./perf record -e cpu-clock --call-graph fp ls
> [ 9619.423884] hrtimer: interrupt took 733000 ns
> [ 9619.977017] Unable to handle kernel paging request at virtual
> address ffffffffffffff94
> [ 9620.214736] Oops [#1]
> [ 9620.289893] Modules linked in:
> [ 9620.391378] CPU: 0 PID: 264 Comm: ls Not tainted
> 5.3.0-rc5-00003-gb008f6bcd67c #4
> [ 9620.640176] sepc: ffffffe0001a198c ra : ffffffe0001a199a sp :
> ffffffe000093720
> [ 9620.880366] gp : ffffffe00097dad8 tp : ffffffe000082e40 t0 : 000000000=
0046000
> [ 9621.120564] t1 : 0000000000000002 t2 : 0000000000000007 s0 : ffffffe00=
0093760
> [ 9621.360768] s1 : ffffffe000093788 a0 : 0000000000000003 a1 : 000000000=
0000000
> [ 9621.600991] a2 : ffffffffffffff8c a3 : 0000000000001fa0 a4 : 000000000=
0000010
> [ 9621.841181] a5 : 0000000000000002 a6 : 0000000000000001 a7 : ffffffe07=
9b34e10
> [ 9622.081400] s2 : ffffffffffffff9c s3 : ffffffe000000000 s4 : 000000000=
0001ff8
> [ 9622.321618] s5 : ffffffe000093da0 s6 : ffffffe00097d540 s7 : ffffffe07=
a1517a0
> [ 9622.561811] s8 : 000008bf01c7ff60 s9 : ffffffe000235b2a s10: 000000020=
0000120
> [ 9622.802015] s11: 0000000000000001 t3 : ffffffe079b34e00 t4 : 000000000=
0000001
> [ 9623.042194] t5 : 0000000000000008 t6 : ffffffe0009208d0
> [ 9623.218785] sstatus: 0000000200000100 sbadaddr: ffffffffffffff94
> scause: 000000000000000d
> [ 9623.490850] ---[ end trace 49043f28e856d84d ]---
> [ 9623.644217] Kernel panic - not syncing: Fatal exception in interrupt
> [ 9623.855470] SMP: stopping secondary CPUs
> [ 9623.985955] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
