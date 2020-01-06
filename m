From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Date: Mon, 6 Jan 2020 11:32:53 +0800
Message-ID: <CAJF2gTRd=PmNAj3T-_pD-k4x7aOgzRr54h_J-HCqUjLvVNCoTg@mail.gmail.com>
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106024515.GA1021@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Kao <alankao@andestech.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, aou@eecs.berkeley.edu, Guo Ren <ren_guo@c-sky.com>, Arnd Bergmann <arnd@arndb.de>, Atish Patra <atish.patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org, vincent.chen@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, zong.li@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>, greentime.hu@sifive.com, linux-riscv@lists.infradead.org, Bin Meng <bmeng.cn@gmail.com>
List-Id: linux-arch.vger.kernel.org

Let's talk about libc abi for sigcontext and our cpu has the vector
features, so we need start the work to support stress-test.

I think it's the same to andes, because andes also announced the
vector processor. The linux and libc are only small part of vector
ISA, let's work together :)

On Mon, Jan 6, 2020 at 10:45 AM Alan Kao <alankao@andestech.com> wrote:
>
> Hi Guo,
>
> On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > 128bit-vlen and it's based on linux-5.5-rc4.
> >
>
> According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
> that "we plan to only accept patches for new modules or extensions that have
> been frozen or ratified by the RISC-V Foundation."
>
> Is v0.8 ratified enough for now?
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
