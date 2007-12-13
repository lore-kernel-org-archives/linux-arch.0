Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([86.65.150.130]:50902 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbXLMWsq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Dec 2007 17:48:46 -0500
Message-ID: <4761B6BB.1070504@cosmosbay.com>
Date: Thu, 13 Dec 2007 23:48:27 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: RFC: remove __read_mostly
References: <20071213222044.GH21616@stusta.de>
In-Reply-To: <20071213222044.GH21616@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Adrian Bunk a écrit :
> I tried the following patch with a full x86 .config [1]:
> 
> --- a/include/asm-x86/cache.h
> +++ b/include/asm-x86/cache.h
> -#define __read_mostly __attribute__((__section__(".data.read_mostly")))
> +/* #define __read_mostly __attribute__((__section__(".data.read_mostly"))) */
> 
> The result [2,3] was:
> 
> -rwxrwxr-x 1 bunk bunk 46607243 2007-12-13 19:50 vmlinux.old
> -rwxrwxr-x 1 bunk bunk 46598691 2007-12-13 21:55 vmlinux
> 
> It's not a surprise that the kernel can become bigger when __read_mostly 
> gets used, especially in cases where __read_mostly prevents gcc 
> optimizations.
> 
> My question is:
> Is there anywhere in the kernel a case where __read_mostly brings a 
> measurable improvement or can it be removed?

Yes, there are many cases where read_mostly brings huge improvements.

I did test your idea on a 4 CPUS server, and system time was roughly doubled, 
from 11% to 20%

Of course, you noticed that puting a __read_mostly attribute force the linker 
to reserve space for the variable. So a null variable previously in bss 
section (no space in vmlinux file) is now in .data.read_mostly. Not a big deal.

If you want, you could play some .lds games to create sort of a 
"bss.read_mostly" section to save 10000 bytes in vmlinux.

