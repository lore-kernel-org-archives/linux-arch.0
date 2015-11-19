Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:59872 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405AbbKSQdg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 11:33:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on 32-bit machines
Date: Thu, 19 Nov 2015 17:28:20 +0100
Message-ID: <3830931.6tMHPeiNRU@wuerfel>
In-Reply-To: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151119162820.Yb7wB-osaS4KkCD9wu_1ojTl1NfZE8caBiToeenZNc8@z>

On Monday 16 November 2015 20:20:38 Nicolas Pitre wrote:
> Arnd,
> 
> Please pull the following branch:
> 
> 	git://git.linaro.org/people/nicolas.pitre/linux div64
> 
> This contains those patches I've initially posted here:
> 
> 	https://lkml.org/lkml/2015/11/2/715
> 
> Only changes to those posted patches are cosmetic improvements such as 
> the use of ilog2() replacing the custom __div64_ffs(). Exposure in 
> linux-next would be a good thing.
> 
> I also included fixes for a couple do_div() misuses that an allyesconfig 
> build turned up after switching ARM to the generic do_div() code.  
> Those patches have been posted separately and addressed to relevant 
> maintainers. They are included here until/unless those maintainers 
> include those patches in their tree.
> 
> Original cover letter:
> 
> This is a generalization of the optimization I produced for ARM a decade
> ago to turn constant divisors into a multiplication by the divisor
> reciprocal. Turns out that after all those years gcc is still not
> optimizing things on its own for that case.
> 
> This has important performance benefits as discussed in this thread:
> 
> 	https://lkml.org/lkml/2015/10/28/851
> 
> This series brings the formerly ARM-only optimization to all 32-bit
> architectures using C code by default.  The possibility for the actual
> multiplication to be implemented in assembly is provided in order to get
> optimal code.  The ARM version can be used as an example implementation
> for other interested architectures to implement.
> 

Pulled into my asm-generic tree now, it should show up in linux-next
tomorrow.

Thanks,

	Arnd
