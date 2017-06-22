Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33643 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbdFVVDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 17:03:18 -0400
MIME-Version: 1.0
In-Reply-To: <401cdb64-6fdb-be30-b8bc-bf51c1a35074@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com> <20170622164817.25515-5-logang@deltatee.com>
 <20170622210828.27304f6a@alans-desktop> <401cdb64-6fdb-be30-b8bc-bf51c1a35074@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Jun 2017 23:03:17 +0200
Message-ID: <CAK8P3a1R-uvjjs=UpbvJjVXnFpD_OL1aRsw0KE_GkvNy+dVj8g@mail.gmail.com>
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Message-ID: <20170622210317.XVOwBzdupaQYcMhRh3bhITz_OMPMtStli482QJgt-PQ@z>

On Thu, Jun 22, 2017 at 10:09 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 6/22/2017 2:08 PM, Alan Cox wrote:
>>
>> But this does not do the same thing as an ioread64 with regards to
>> atomicity or side effects on the device. The same is true of the other
>> hacks. You either have a real 64bit single read/write from MMIO space or
>> you don't. You can't fake it.
>
>
> Yes, I know. But is it not better than having every driver that wants to use
> these functions fake it themselves?

Drivers that want a non-atomic variant should include either
include/linux/io-64-nonatomic-hi-lo.h or include/linux/io-64-nonatomic-lo-hi.h
depending on what they need. Drivers that require 64-bit I/O should
probably just depend on CONFIG_64BIT and maybe use readq/writeq.

I see that there are exactly two drivers calling ioread64/iowrite64:
drivers/crypto/caam/ is architecture specific and
drivers/ntb/hw/intel/ntb_hw_intel.c already has a workaround that should
make it build on alpha.

        Arnd
