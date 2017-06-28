Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46704 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdF1QDG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2017 12:03:06 -0400
References: <20170627230204.16410-1-logang@deltatee.com>
 <20170627230204.16410-2-logang@deltatee.com>
 <CAK8P3a2tL5wdCRscpyb6fW+LQVM05urud=YQRS-3+=4w53rmvg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e32bd057-2069-63c9-b75d-3a97a736d898@deltatee.com>
Date: Wed, 28 Jun 2017 10:02:57 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2tL5wdCRscpyb6fW+LQVM05urud=YQRS-3+=4w53rmvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] io-64-nonatomic: add io{read|write}64[be] macros
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jyri Sarha <jsarha@ti.com>, Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Message-ID: <20170628160257.-OPjOqeKuHiycSrT1FBRmnJe8xCaeOTtRuby3pYr-rA@z>



On 28/06/17 04:11 AM, Arnd Bergmann wrote:
> This is wrong since ioread* is not the same read* on x86 and other
> architectures that have native PCI PIO accessors, or that require
> additional barriers for those.
> 
> You have to copy hi_lo_readq() here, and call ioread32 twice instead
> of calling readl() twice. Same for iowrite64.
> 
>> +#ifndef ioread64be
>> +#define ioread64be(p) be64_to_cpu(ioread64(p))
>> +#endif
> 
> This has another problem: ioread64() is defined to access little-endian
> registers, just like readq(). This means that instead of be64_to_cpu()
> you need swab64() and always perform the byte swap, otherwise this
> would be broken on big-endian architectures.

Ah, ok, understood. I'll see if I can fix both these issues.

Thanks,

Logan
