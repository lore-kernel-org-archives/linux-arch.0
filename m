From: Pantelis Antoniou <panto@embeddedalley.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 14:05:48 +0300
Message-ID: <4B443E30-4B6C-4E37-A038-AB05214EE78C@embeddedalley.com>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop> <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org> <1211922621.3286.80.camel@pasglop> <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <1211924335.3286.89.camel@pasglop> <20080527214241.GA22636@parisc-linux.org> <1211926636.3286.100.camel@pasglop> <20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cpe-089228.fiber.wadsnet.net ([65.114.89.228]:42858 "HELO
	postoffice.embeddedalley.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751065AbYE2LMf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 07:12:35 -0400
In-Reply-To: <20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: benh@kernel.crashing.org, Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com


On 28 =CE=9C=CE=B1=CF=8A 2008, at 11:36 =CE=A0=CE=9C, Haavard Skinnemoe=
n wrote:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>> I'm happy to say that __raw is purely about ordering and make them
>>>> byteswap on powerpc tho (ie, make them little endian like the non-=
=20
>>>> raw
>>>> counterpart).
>>>
>>> That would break a lot of drivers.
>>
>> How many actually use __raw_ * ?
>
> I do -- in all the drivers for on-chip peripherals that are shared
> between AT91 ARM (LE) and AVR32 (BE). Since everything goes on inside
> the chip, we must use LE accesses on ARM and BE accesses on AVR32.
>
> Currently, this is the only interface I know that can do native-endia=
n
> accesses, so if you take it away, I'm gonna need an alternative
> interface that doesn't do byteswapping.
>
> Haavard

I certainly do too.

Quite a lot of SoC specific drivers use __raw for accessing their
on-chip peripherals.

Please don't change the __raw semantics, you'll end up breaking almost
everything that's BE.

-- Pantelis
