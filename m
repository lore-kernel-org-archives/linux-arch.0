Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35921 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdGaSDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2017 14:03:06 -0400
MIME-Version: 1.0
In-Reply-To: <65ca8848-3a99-bda8-5165-9453b70316fa@deltatee.com>
References: <20170726231917.6073-1-logang@deltatee.com> <20170726231917.6073-4-logang@deltatee.com>
 <CAHp75Vcv7UCpnGY+mL7CMU5u9hCUxwaYWNsg58BoWBJGAFX4tQ@mail.gmail.com>
 <5c52d908-3b77-c5c6-99a7-1164d878ac95@deltatee.com> <CAHp75Ve619EE9ePy2zj+MjS7-MW3u_k2BQ5kc9iFBMYYQ9nMWQ@mail.gmail.com>
 <3a4c9453-20be-8164-85eb-5ad4d596a299@deltatee.com> <CAHp75VdE-xRHDEfmmURtoak6+4Vga4szLnDkGjtJHm47DZRCAQ@mail.gmail.com>
 <65ca8848-3a99-bda8-5165-9453b70316fa@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 31 Jul 2017 21:03:03 +0300
Message-ID: <CAHp75VdOh+aa771g=T-f=XMkS5nY-7VFK6miqyxw0dOA8YOJyw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20170731180303.UaWwl1-CdOnx5AhO33oXbJNOwdKQLUoAgUT__OBNPW4@z>

On Mon, Jul 31, 2017 at 9:00 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 31/07/17 11:58 AM, Andy Shevchenko wrote:
>> On Mon, Jul 31, 2017 at 7:31 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>> On 31/07/17 10:10 AM, Andy Shevchenko wrote:
>>>> Some drivers (hardware) would like to have non-atomic MMIO accesses
>>>> when readq() defined
>>>
>>> Huh? But that's the whole point of the io64-nonatomic header. If a
>>> driver wants a specific non-atomic access they should just code two 32
>>> bit accesses.
>
>> You mean to call them directly as lo_hi_XXX() or hi_lo_XXX() ?
>> Yes it would work.
>
> I suppose you could do that too but I really meant just using two io32
> calls. That's the most explicit way to indicate you want a non-atomic
> access.

Per commit 3a044178cccf they are exactly created for this kind of cases.

-- 
With Best Regards,
Andy Shevchenko
