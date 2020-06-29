From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Date: Mon, 29 Jun 2020 19:07:04 +0100
Message-ID: <20200629180703.GX1551@shell.armlinux.org.uk>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
 <20200629155401.GB900899@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200629155401.GB900899@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 29, 2020 at 11:54:01AM -0400, Arvind Sankar wrote:
> On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Specifically, this would have made a recently fixed bug very obvious:
> > 
> > ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> > 
> > Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> > 
> > Add missing text stub sections .vfp11_veneer and .v4_bx.
> > 
> > Add debug sections explicitly.
> > 
> > Finally enable orphan section warning.
> 
> This is unrelated to this patch as such, but I noticed that ARM32/64 places
> the .got section inside .text -- is that expected on ARM?

Do you mean in general, in the kernel vmlinux, in the decompressor
vmlinux or ... ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
