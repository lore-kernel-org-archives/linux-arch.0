From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 09 Feb 2016 17:08:44 +0100
Message-ID: <3600593.0vxxUHHYns@wuerfel>
References: <20160209164104.4ecaa0ce@canb.auug.org.au> <3561538.HMPaSbaoce@wuerfel> <20160209160117.GB9332@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160209160117.GB9332@leverpostej>
Sender: linux-next-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
List-Id: linux-arch.vger.kernel.org

On Tuesday 09 February 2016 16:01:18 Mark Rutland wrote:
> That builds fine for me atop of for-next/pgtable, both 64-bit and
> 32-bit.
> 
> GCC seems to treat enum fixed_addresses the same as unsigned. Only if I
> change the type of idx in fixmap.h (e.g. to char) do I get a conflict
> against paravirt.h

Interesting.


The patch seems fine then:

Acked-by: Arnd Bergmann <arnd@arndb.de>
