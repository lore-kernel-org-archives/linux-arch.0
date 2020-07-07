From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Tue, 7 Jul 2020 08:51:07 -0700
Message-ID: <20200707155107.GA3357035@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
 <20200629232059.GA3787278@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200629232059.GA3787278@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>, Jiong Wang <jiong.wang@netronome.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 29, 2020 at 04:20:59PM -0700, Sami Tolvanen wrote:
> Hi Masahiro,
> 
> On Mon, Jun 29, 2020 at 01:56:19AM +0900, Masahiro Yamada wrote:
> > I also got an error for
> > ARCH=arm64 allyesconfig + CONFIG_LTO_CLANG=y
> > 
> > 
> > 
> > $ make ARCH=arm64 LLVM=1 LLVM_IAS=1
> > CROSS_COMPILE=~/tools/aarch64-linaro-7.5/bin/aarch64-linux-gnu-
> > -j24
> > 
> >   ...
> > 
> >   GEN     .version
> >   CHK     include/generated/compile.h
> >   UPD     include/generated/compile.h
> >   CC      init/version.o
> >   AR      init/built-in.a
> >   GEN     .tmp_initcalls.lds
> >   GEN     .tmp_symversions.lds
> >   LTO     vmlinux.o
> >   MODPOST vmlinux.symvers
> >   MODINFO modules.builtin.modinfo
> >   GEN     modules.builtin
> >   LD      .tmp_vmlinux.kallsyms1
> > ld.lld: error: undefined symbol: __compiletime_assert_905
> > >>> referenced by irqbypass.c
> > >>>               vmlinux.o:(jeq_imm)
> > make: *** [Makefile:1161: vmlinux] Error 1
> 
> I can reproduce this with ToT LLVM and it's BUILD_BUG_ON_MSG(..., "value
> too large for the field") in drivers/net/ethernet/netronome/nfp/bpf/jit.c.
> Specifically, the FIELD_FIT / __BF_FIELD_CHECK macro in ur_load_imm_any.
> 
> This compiles just fine with an earlier LLVM revision, so it could be a
> relatively recent regression. I'll take a look. Thanks for catching this!

After spending some time debugging this with Nick, it looks like the
error is caused by a recent optimization change in LLVM, which together
with the inlining of ur_load_imm_any into jeq_imm, changes a runtime
check in FIELD_FIT that would always fail, to a compile-time check that
breaks the build. In jeq_imm, we have:

    /* struct bpf_insn: _s32 imm */
    u64 imm = insn->imm; /* sign extend */
    ...
    if (imm >> 32) { /* non-zero only if insn->imm is negative */
    	/* inlined from ur_load_imm_any */
	u32 __imm = imm >> 32; /* therefore, always 0xffffffff */

        /*
	 * __imm has a value known at compile-time, which means
	 * __builtin_constant_p(__imm) is true and we end up with
	 * essentially this in __BF_FIELD_CHECK:
	 */
	if (__builtin_constant_p(__imm) && __imm <= 255)
	      __compiletime_assert_N();

The compile-time check comes from the following BUILD_BUG_ON_MSG:

    #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)		\
    ...
	BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
			 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
			 _pfx "value too large for the field"); \

While we could stop the compiler from performing this optimization by
telling it to never inline ur_load_imm_any, we feel like a better fix
might be to replace FIELD_FIT(UR_REG_IMM_MAX, imm) with a simple imm
<= UR_REG_IMM_MAX check that won't trip a compile-time assertion even
when the condition is known to fail.

Jiong, Jakub, do you see any issues here?

Sami
