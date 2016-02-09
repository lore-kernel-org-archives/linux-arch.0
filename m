From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 9 Feb 2016 14:35:54 +0000
Message-ID: <20160209143554.GA9332@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
 <20160209073428.GA24863@sudip-pc>
 <20160209120032.GB19840@leverpostej>
 <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 09, 2016 at 02:48:26PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 9, 2016 at 1:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Feb 09, 2016 at 01:04:28PM +0530, Sudip Mukherjee wrote:
> >> On Tue, Feb 09, 2016 at 04:41:04PM +1100, Stephen Rothwell wrote:
> >> > Changes since 20160208:
> >>
> >> tilepro, tilegx, mips defconfig build fails with the error:
> >> ../include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
> >> ../include/asm-generic/fixmap.h:77:2: error: implicit declaration of
> >> function '__set_fixmap' [-Werror=implicit-function-declaration]
> >>
> >> caused by:
> >> commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static inline")
> >>
> >> Reverting the commit fixes the issue.
> >
> > Sorry about this.
> >
> > Is seems any arch without its own __set_fixmap may be adversely
> > affected.
> >
> > I can't easily stub __set_fixmap as it's not implemented as a macro.
> 
> But you can add a forward declaration?

Good point. That seems to work (tested on arm64, mips, tilegx).

Arnd, Catalin, happy with the bloew fixup to the original patch?

Mark.

---->8----
From e53a0fa34689cca13846475fb5a7cb4c7da87384 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 9 Feb 2016 14:27:36 +0000
Subject: [PATCH] asm-generic: Fix build when __set_fixmap is absent

Commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static
inline") relied on the architecture code to define a __set_fixmap
function, even if unused. This broke the build for architectures which
do not implement __set_fixmap:

../include/asm-generic/fixmap.h:Infunction'__set_fixmap_offset':
../include/asm-generic/fixmap.h:77:2:error:implicitdeclarationof
function'__set_fixmap'[-Werror=implicit-function-declaration]

As we only require the prototype to be present, add this to
asm-generic/fixmap.h, preventing build failures on these architectures.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
---
 include/asm-generic/fixmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index f9c27b6..e5255ff 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -69,6 +69,8 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
 #endif
 
+void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
+
 /* Return a pointer with offset calculated */
 static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
 						phys_addr_t phys,
-- 
1.9.1
