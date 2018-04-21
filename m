Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:43589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752911AbeDUR3g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Apr 2018 13:29:36 -0400
Subject: Re: [PATCH v16 2/7] parisc: iomap: introduce io{read|write}64
References: <20180420182403.9691-1-logang@deltatee.com>
 <20180420182403.9691-3-logang@deltatee.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <4cf30fbf-4972-2b1d-f327-99c20f07e84e@gmx.de>
Date: Sat, 21 Apr 2018 19:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180420182403.9691-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180421172914.UKmt-bQ323nR1nqUp08ntGi2MKP2ePsCr8Q_T2XWmZw@z>

On 20.04.2018 20:23, Logan Gunthorpe wrote:
> Add support for io{read|write}64() functions in parisc architecture.
> These are pretty straightforward copies of similar functions which
> make use of readq and writeq.
> 
> Also, indicate that the lo_hi and hi_lo variants of these functions
> are not provided by this architecture.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge
