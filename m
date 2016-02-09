From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 9 Feb 2016 12:00:33 +0000
Message-ID: <20160209120032.GB19840@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
 <20160209073428.GA24863@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209073428.GA24863@sudip-pc>
Sender: linux-next-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, linux-arch@vger.kernel.org, Laura Abbott <labbott@fedoraproject.org>
List-Id: linux-arch.vger.kernel.org

Hi,

On Tue, Feb 09, 2016 at 01:04:28PM +0530, Sudip Mukherjee wrote:
> On Tue, Feb 09, 2016 at 04:41:04PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20160208:
> 
> tilepro, tilegx, mips defconfig build fails with the error:
> ../include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
> ../include/asm-generic/fixmap.h:77:2: error: implicit declaration of
> function '__set_fixmap' [-Werror=implicit-function-declaration]
> 
> caused by:
> commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static inline")
> 
> Reverting the commit fixes the issue.

Sorry about this.

Is seems any arch without its own __set_fixmap may be adversely
affected.

I can't easily stub __set_fixmap as it's not implemented as a macro.

I think we can stick with a macro and remove 'addr', by returning the
result of the expression directly. As fix_to_virt gave us an unsigned
long I think the types should line up (i.e. the result will be at least
unsigned long wide).

Arnd, would you be happy with the below patch instead? 

It builds fine for arm, arm64, mips, and tilegx in local testing.

Thanks,
Mark.
---->8----
From d30ae6ebbae2c969ee36ef548711493b64c2be41 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 9 Feb 2016 11:43:55 +0000
Subject: [PATCH] asm-generic: Avoid variable in __set_fixmap_offset

Currently __set_fixmap_offset is a macro function which has a local
variable called 'addr'. If a caller passes a 'phys' parameter which is
derived from a variable also called 'addr', the local variable will
shadow this, and the compiler will complain about the use of an
uninitialized variable.

It is likely that fixmap users may use the name 'addr' for variables
that may be directly passed to __set_fixmap_offset, or that may be
indirectly generated via other macros. Rather than placing the burden on
callers to avoid the name 'addr', this patch removes the temporary
'addr' variable in __set_fixmap_offset, directly returning the result of
the address calculation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 include/asm-generic/fixmap.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 1cbb833..ae2cc43 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -72,10 +72,8 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 /* Return a pointer with offset calculated */
 #define __set_fixmap_offset(idx, phys, flags)		      \
 ({							      \
-	unsigned long addr;				      \
 	__set_fixmap(idx, phys, flags);			      \
-	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
-	addr;						      \
+	fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	      \
 })
 
 #define set_fixmap_offset(idx, phys) \
-- 
1.9.1
