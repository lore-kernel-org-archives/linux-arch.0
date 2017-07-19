Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41909 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbdGSQEc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Jul 2017 12:04:32 -0400
References: <20170718165528.7383-1-logang@deltatee.com>
 <20170718165528.7383-2-logang@deltatee.com>
 <87iniphsug.fsf@concordia.ellerman.id.au>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <15b6ea7d-5817-c0cd-aee4-c8a52d8808f9@deltatee.com>
Date: Wed, 19 Jul 2017 10:04:06 -0600
MIME-Version: 1.0
In-Reply-To: <87iniphsug.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/5] powerpc: io.h: move iomap.h include so that it can
 use readq/writeq defs
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
Message-ID: <20170719160406.Tuxk6yjKbw9cCA9z9-hwgApsu7y9vWm6Z4vUk92tAr0@z>



On 18/07/17 11:57 PM, Michael Ellerman wrote:
> Seems fair enough, have you tested it at all?

It's only been compile tested and the kbuild robot has beat up on it a bit.

Thanks,

Logan
