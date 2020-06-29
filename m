From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Date: Mon, 29 Jun 2020 20:03:16 +0100
Message-ID: <20200629190316.GY1551@shell.armlinux.org.uk>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
 <20200629155401.GB900899@rani.riverdale.lan>
 <20200629180703.GX1551@shell.armlinux.org.uk>
 <20200629181514.GA1046442@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgF2TD0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:03:26 -0400
Content-Disposition: inline
In-Reply-To: <20200629181514.GA1046442@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:15:14PM -0400, Arvind Sankar wrote:
> On Mon, Jun 29, 2020 at 07:07:04PM +0100, Russell King - ARM Linux admin wrote:
> > On Mon, Jun 29, 2020 at 11:54:01AM -0400, Arvind Sankar wrote:
> > > On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> > > > We don't want to depend on the linker's orphan section placement
> > > > heuristics as these can vary between linkers, and may change between
> > > > versions. All sections need to be explicitly named in the linker
> > > > script.
> > > > 
> > > > Specifically, this would have made a recently fixed bug very obvious:
> > > > 
> > > > ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> > > > 
> > > > Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> > > > 
> > > > Add missing text stub sections .vfp11_veneer and .v4_bx.
> > > > 
> > > > Add debug sections explicitly.
> > > > 
> > > > Finally enable orphan section warning.
> > > 
> > > This is unrelated to this patch as such, but I noticed that ARM32/64 places
> > > the .got section inside .text -- is that expected on ARM?
> > 
> > Do you mean in general, in the kernel vmlinux, in the decompressor
> > vmlinux or ... ?
> > 
> 
> Sorry, in the kernel vmlinux. ARM_TEXT includes *(.got) for 32-bit, and
> the 64-bit vmlinux.lds.S includes it in .text as well. The decompressor
> for 32-bit keeps it separate for non-EFI stub kernel and puts it inside
> .data for EFI stub.

The main 32-bit kernel image doesn't use the .got - I don't think it
actually even exists.

The decompressor (non-EFI) uses the .got as a way of getting position
independence, and that must be part of the binary image at a fixed
offset from the .text section.  The decompressor self-fixes up the
GOT entries.

In the case of the decompressor being flashed and executed from NOR
flash, the decompressor must be built for the specific address(es)
that it will reside (which does away with the .got table.)

For EFI, it needs to be in the .data section (which is in that case
always a fixed offset from .text) so that it can be written to so the
fix-ups work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
