Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55387 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab3BFXB0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2013 18:01:26 -0500
Message-ID: <5112E0C3.1080706@dawncrow.de>
Date: Thu, 07 Feb 2013 00:01:23 +0100
From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
MIME-Version: 1.0
Subject: Re: [PATCH] arm: Preserve TPIDRURW on context switch
References: <5112DC7E.4020108@dawncrow.de> <20130206225150.GL17833@n2100.arm.linux.org.uk>
In-Reply-To: <20130206225150.GL17833@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20130206230123.-gp3_7ra6UNP54xMDfaNhpKyuSBjWzWrffw08sFWuHY@z>

Am 06.02.2013 23:51, schrieb Russell King - ARM Linux:
> On Wed, Feb 06, 2013 at 11:43:10PM +0100, André Hentschel wrote:
>> There are more and more applications coming to WinRT, Wine could support them,
>> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
>> This register must be preserved per thread instead of being cleared.
> 
> I'd prefer this was done a little more sensitively to those CPUs where
> loads/stores are expensive, namely:
> 
>> +
>> +	@ preserve TPIDRURW register state
>> +	get_tls2	r3, r4, r5
>> +	str	r3, [r1, #TI_TP2_VALUE]
>> +	ldr	r3, [r2, #TI_TP2_VALUE]
>> +	set_tls2	r3, r4, r5
> 
> those two loads/stores get omitted from the thread switching if the CPU
> doesn't support it.  Do you think that's something you could do?

No, i'm not sure how to improve this. How does the process can continue, can you or someone else fix that and add his Signed-off-by?


-- 

Best Regards, André Hentschel
