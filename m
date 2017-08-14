From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fwd: struct pt_regs missing in /usr/include/ tree for eBPF
 program compile
Date: Mon, 14 Aug 2017 16:39:03 +0200
Message-ID: <CAK8P3a2zr9E4NyJjcGR86Qm=1=1iMiWrDxcRrJC8vBhVr7qjUA@mail.gmail.com>
References: <c8a10777-9da1-461e-0b69-2c1280fa0ee7@linux.vnet.ibm.com>
 <49c5e39b-a7d9-1e2d-24ec-57852f7d1e51@linux.vnet.ibm.com> <CAADnVQKpaF+3EZKMtMBdKLatEQGytqc9YJQQSSFRFQ=7THpvTw@mail.gmail.com>
 <598492A6.10707@iogearbox.net> <20170814120807.GB3305@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814120807.GB3305@osiris>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, ast@kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, David Miller <davem@davemloft.net>, yhs@fb.com, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 14, 2017 at 2:08 PM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> I really don't think that struct pt_regs is part of uapi and should be
> exported. We did change the layout of the pt_regs structure more than once
> and would like to be able to do so in the future as well.

On some architectures, pt_regs is definitely part of the uapi, as
we define sigcontext in terms of pt_regs:

arch/cris/include/uapi/asm/sigcontext.h:        struct pt_regs regs;
/* needs to be first */
arch/m32r/include/uapi/asm/sigcontext.h:        struct pt_regs *sc_pt_regs;
arch/microblaze/include/uapi/asm/sigcontext.h:  struct pt_regs regs;
arch/powerpc/include/uapi/asm/sigcontext.h:     struct pt_regs  __user *regs;
arch/tile/include/uapi/asm/sigcontext.h: * struct sigcontext has the
same shape as struct pt_regs,
arch/unicore32/include/uapi/asm/sigcontext.h:   struct pt_regs regs;

On other architectures, they just use the same layout but different names.

arm32 also uses pt_regs in struct kvm_regs, the other ones don't:

arch/arm/include/uapi/asm/kvm.h:        struct pt_regs usr_regs;
 /* R0_usr - R14_usr, PC, CPSR */

> In addition what about compat processes? Most architectures define their
> struct pt_regs with "unsigned long" members, which have different sizes for
> 32/64 bit, while the structure on the kernel stack contains 64 bit
> members. And as far as I know the bpf test cases want to access the kernel
> stack, no? Then this seems to be broken also.

Right.

      Arnd
