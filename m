Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:20518
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753564AbaDWSac convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 14:30:32 -0400
From: "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Wed, 23 Apr 2014 18:15:34 +0000
Message-ID: <E780DB23-B6A3-427B-8F33-71378088A3F5@caviumnetworks.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<5354AD36.5090809@zytor.com>
	<CAFiDJ5861HE4AXtio-8uNJppWE2oaPt9_OKyGV=Myb_3vPrOVA@mail.gmail.com>
	<16597012.pEkDc99HDN@wuerfel>
 <CAFiDJ5_dUpVTSeC36AfNKVN7BOa9GQ5vwSEWricm=8Sam9mR2A@mail.gmail.com>,<5357FF8E.9010809@codesourcery.com>
In-Reply-To: <5357FF8E.9010809@codesourcery.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <cltang@codesourcery.com>
Cc: Ley Foon Tan <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Catalin.Marinas@arm.com" <Catalin.Marinas@arm.com>, Andrew Pinski <apinski@cavium.com>
Message-ID: <20140423181534.BHv2RAIJy_joSCwixR-2kbxT7mqtm9UGqV86MjQELX0@z>



> On Apr 23, 2014, at 10:59 AM, "Chung-Lin Tang" <cltang@codesourcery.com> wrote:
> 
>> On 2014/4/22 07:20 PM, Ley Foon Tan wrote:
>> On Tue, Apr 22, 2014 at 6:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tuesday 22 April 2014 18:37:11 Ley Foon Tan wrote:
>>>>>> Hi Arnd and Peter Anvin,
>>>>>> 
>>>>>> Other than 64-bit time_t, clock_t and suseconds_t, can you confirm
>>>>>> that we don't need to have 64 bit off_t? See detail in link below.
>>>>>> I can submit the patches for 64-bit time changes
>>>>>> (include/asm-generic/posix_types.h and other archs) if everyone is
>>>>>> agreed on this.
>>>> 
>>>> Yes.
>> Okay, will doing that.
> 
> I believe that arm64 ILP32 will also be affected. What is the status of
> this configuration? Has the glibc/kernel ABI been finalized?

Not yet.  I am still working out the signal handling part. But we already agreed on 64bit time_t, clock_t, and suseconds_t.  And we agreed to a 64bit offset_t too. 

On a related note suseconds in the timespec in posix is defined to be long. So it would nice if the kernel ignores the upper 32bits so we (glibc developers) can fix this for new targets including x32 and arm64/ilp32. 

Thanks,
Andrew

> 
> Thanks,
> Chung-Lin
> 
