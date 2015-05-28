Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:10548 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbbE1Sts (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2015 14:49:48 -0400
Message-ID: <556761D2.9040908@dawncrow.de>
Date: Thu, 28 May 2015 20:43:30 +0200
From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
References: <555CB3D5.7000307@dawncrow.de> <20150527143648.GA4232@arm.com>
In-Reply-To: <20150527143648.GA4232@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>
Message-ID: <20150528184330.pldXYIrJhoaq9fJwamA_X0zpY_WCmslieoqvXI7QsQI@z>

Am 27.05.2015 um 16:36 schrieb Will Deacon:
> Hi André,
> 
> On Wed, May 20, 2015 at 05:18:29PM +0100, André Hentschel wrote:
>> From: André Hentschel <nerv@dawncrow.de>
>>
>> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
>> register on ARM is preserved per thread.
>>
>> This patch does it analogous to the ARM patch, but for compat mode on ARM64.
>>
>> Signed-off-by: André Hentschel <nerv@dawncrow.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>
>> ---
>> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
>>
>> v2: Trying to address suggestions by Will Deacon
>>
>> @Will Deacon: 	The macro you suggested is not helpful it seems, instead i introduced
>> 		static functions. They also could be macros i guess, but it seems
>> 		much cleaner to me to use functions as it only affects one file.
> 
> I wanted to understand in more detail why the macro didn't work out for
> you, so I trued hacking together my own version of the patch (see below).
> It seems to hold up to light testing, so it would be good to know where
> you ran into problems.
> 
>> Should the final version be send to rmk's patchtracker or will someone
>> else pick it up?
> 
> This is an arm64 patch, so either Catalin or me will pick it up directly
> when it's ready to be merged.
> 
> Will

Your patch works, you can add me as Tested-by. :)
My bad was that i didn't know that macro style (returning a variable conditionally with c code)
Sadly no new commit by me :(
