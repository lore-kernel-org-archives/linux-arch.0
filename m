Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:56751 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdGaSAf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Jul 2017 14:00:35 -0400
References: <20170726231917.6073-1-logang@deltatee.com>
 <20170726231917.6073-4-logang@deltatee.com>
 <CAHp75Vcv7UCpnGY+mL7CMU5u9hCUxwaYWNsg58BoWBJGAFX4tQ@mail.gmail.com>
 <5c52d908-3b77-c5c6-99a7-1164d878ac95@deltatee.com>
 <CAHp75Ve619EE9ePy2zj+MjS7-MW3u_k2BQ5kc9iFBMYYQ9nMWQ@mail.gmail.com>
 <3a4c9453-20be-8164-85eb-5ad4d596a299@deltatee.com>
 <CAHp75VdE-xRHDEfmmURtoak6+4Vga4szLnDkGjtJHm47DZRCAQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <65ca8848-3a99-bda8-5165-9453b70316fa@deltatee.com>
Date: Mon, 31 Jul 2017 12:00:11 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75VdE-xRHDEfmmURtoak6+4Vga4szLnDkGjtJHm47DZRCAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/6] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20170731180011.eb6tkAgrAkDJUZIDBix94Pgcy5O_6cZE8WM_YF6IiQ0@z>



On 31/07/17 11:58 AM, Andy Shevchenko wrote:
> On Mon, Jul 31, 2017 at 7:31 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> On 31/07/17 10:10 AM, Andy Shevchenko wrote:
>>> Some drivers (hardware) would like to have non-atomic MMIO accesses
>>> when readq() defined
>>
>> Huh? But that's the whole point of the io64-nonatomic header. If a
>> driver wants a specific non-atomic access they should just code two 32
>> bit accesses.

> You mean to call them directly as lo_hi_XXX() or hi_lo_XXX() ?
> Yes it would work.

I suppose you could do that too but I really meant just using two io32
calls. That's the most explicit way to indicate you want a non-atomic
access.

Logan
