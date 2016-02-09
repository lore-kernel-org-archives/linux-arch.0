From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 9 Feb 2016 13:04:28 +0530
Message-ID: <20160209073428.GA24863@sudip-pc>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209164104.4ecaa0ce@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 09, 2016 at 04:41:04PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20160208:

tilepro, tilegx, mips defconfig build fails with the error:
../include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
../include/asm-generic/fixmap.h:77:2: error: implicit declaration of
function '__set_fixmap' [-Werror=implicit-function-declaration]

caused by:
commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static inline")

Reverting the commit fixes the issue.

regards
sudip
