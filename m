Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39884 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755852AbcBIMBD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Feb 2016 07:01:03 -0500
Date: Tue, 9 Feb 2016 12:00:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Tree for Feb 9
Message-ID: <20160209120032.GB19840@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
 <20160209073428.GA24863@sudip-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160209073428.GA24863@sudip-pc>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, linux-arch@vger.kernel.org, Laura Abbott <labbott@fedoraproject.org>
Message-ID: <20160209120033.x45QAE2f1Abg_LraXUWTl8jwbkPSsOp50KnAczex-2Y@z>

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
