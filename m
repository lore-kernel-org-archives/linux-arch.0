From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/5] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
Date: Thu, 20 Jul 2017 21:10:09 +1000
Message-ID: <87pocvgy9a.fsf@concordia.ellerman.id.au>
References: <20170718165528.7383-1-logang@deltatee.com> <20170718165528.7383-2-logang@deltatee.com> <87iniphsug.fsf@concordia.ellerman.id.au> <15b6ea7d-5817-c0cd-aee4-c8a52d8808f9@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936067AbdGTLKM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 07:10:12 -0400
In-Reply-To: <15b6ea7d-5817-c0cd-aee4-c8a52d8808f9@deltatee.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>

Logan Gunthorpe <logang@deltatee.com> writes:

> On 18/07/17 11:57 PM, Michael Ellerman wrote:
>> Seems fair enough, have you tested it at all?
>
> It's only been compile tested and the kbuild robot has beat up on it a bit.

OK. I don't think I see any way it can break anything, so feel free to
merge it, it'll get boot testing on powerpc once it's in linux-next.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
