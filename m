From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 3/6] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
Date: Sun, 30 Jul 2017 19:03:30 +0300
Message-ID: <CAHp75Vcv7UCpnGY+mL7CMU5u9hCUxwaYWNsg58BoWBJGAFX4tQ@mail.gmail.com>
References: <20170726231917.6073-1-logang@deltatee.com> <20170726231917.6073-4-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20170726231917.6073-4-logang@deltatee.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 27, 2017 at 2:19 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> In order to provide non-atomic functions for io{read|write}64 that will
> use readq and writeq when appropriate. We define a number of variants
> of these functions in the generic iomap that will do non-atomic
> operations on pio but atomic operations on mmio.
>
> These functions are only defined if readq and writeq are defined. If
> they are not, then the wrappers that always use non-atomic operations
> from include/linux/io-64-nonatomic*.h will be used.

Don't you see here a slight problem?

In some cases we want to substitute atomic in favour of non-atomic
when both are defined.
So, please don't do this "smartly".

> +u64 ioread64_lo_hi(void __iomem *addr)
> +{
> +       IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
> +       return 0xffffffffffffffffLL;
> +}

U missed u.

-- 
With Best Regards,
Andy Shevchenko
