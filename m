Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37455 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZTuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2018 15:50:24 -0400
MIME-Version: 1.0
In-Reply-To: <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com> <20180321163745.12286-2-logang@deltatee.com>
 <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com> <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 21:50:23 +0200
Message-ID: <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20180326195023.5skMDWg5oWlEIGzM6NY_UUXocQIS7l38vwaG1uIbNms@z>

On Mon, Mar 26, 2018 at 6:21 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 26/03/18 04:53 AM, Arnd Bergmann wrote:
>> On most architectures, this is not important:
>> - For x86, the stores are aways atomic and no additional barriers
>>   are needed, so the two are the same
>> - For ARM (both 32 and 64-bit), powerpc and many others, we don't
>>   use the generic iowrite() and just fall back to writel() or
>>   writel(swab32()).
>>
>> However, shouldn't we just use the writel(swab32()) logic here as well
>> for the common case rather than risking missing barriers?
>
> Hmm, I don't know... it's complicated?
>
> Doing a bit of digging shows that the existing code was written during a
> time when writel() did not include extra barriers over __raw_writel() in
> any of the common arches.
>
> The commit logs don't seem to provide any guidance as to why this it was
> done this way, but I'd assume it was done to avoid a double swab() call
> on BE arches. Seeing writel() is typically implemented as:
>
> __raw_writel(__cpu_to_le32(value), addr);
>
> Then on BE arches, writel(swab32()) would become:
>
> __raw_writel(swab32(swab32(value)), addr)
>
> Which seems undesirable.

I wouldn't expect it to matter: the byte swap is almost always much
cheaper compared to the actual bus access for the MMIO, and I
would also guess that modern compilers can eliminate the double
byte swap on architectures where writel() is an inline function. Most of
the important architectures use ARCH_USE_BUILTIN_BSWAP, which
guarantees that.

       Arnd
