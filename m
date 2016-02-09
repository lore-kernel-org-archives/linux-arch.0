Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63131 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730AbcBIQIz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 11:08:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 09 Feb 2016 17:08:44 +0100
Message-ID: <3600593.0vxxUHHYns@wuerfel>
In-Reply-To: <20160209160117.GB9332@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au> <3561538.HMPaSbaoce@wuerfel> <20160209160117.GB9332@leverpostej>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
Message-ID: <20160209160844.KYDAXKwmu88QJcKLE1SMJG1lpSzqdw9YCLjS-KpPYSs@z>

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
