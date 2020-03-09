From: Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
Date: Mon, 9 Mar 2020 11:41:37 +0800
Message-ID: <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
References: <20200308094954.13258-1-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45192 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCIDlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 23:41:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id a4so6030714qto.12
        for <linux-arch@vger.kernel.org>; Sun, 08 Mar 2020 20:41:49 -0700 (PDT)
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>, Liu Zhiwei <zhiwei_liu@c-sky.com>

On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>
> The patch implement basic context switch, sigcontext save/restore and
> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> is implemented. We need to discuss about vlen-size for libc sigcontext and
> ptrace (the maximum size of vlen is unlimited in spec).
>
> Puzzle:
> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> before, and riscv also met vlen size problem. Let's discuss the common issue
> for all architectures and we need a better solution for unlimited vlen.
>
> Any help are welcomed :)
>
>  1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3

Hi Guo,

Thanks for your patch.
It seems the qemu repo doesn't have this branch?
