From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: [PATCH 0/4] iomap: fix multiple consistency issues, interface
 cleanup
Date: Mon, 18 Feb 2019 21:30:07 +0100
Message-ID: <20190218203007.GB18457@behemoth.owl.eu.com.local>
References: <cover.1550485787.git.hle@owl.eu.com>
 <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi,

> Nice cleanup! Applied to my asm-generic tree now.

Thanks!

> I notice that you did not add a 'volatile' qualifier in addition to 'const'.
> Is that something you considered doing? I think the traditional
> readl/writel style accessors have them partly for historic reasons,
> and partly to simply the trivial implementation that is based on
> a volatile pointer dereference. Neither is needed here, and I don't
> think we have any drivers that pass volatile pointers into ioread()/iowrite()
> (which would cause a warning), so we can probably leave it at that,
> but it's still a bit inconsistent.

Right, I intentionally omitted the volatile qualifier here.

Adding it to the definitions from asm-generic/iomap.h would require to
also update lib/iomap.c and arch/ implementations. This should, imo, only
be done if really necessary.

From what I've seen, almost all ioread() implementations simply redirect
to readl style accessors. I could not find one implementation that does
something with the addr argument which requires the volatile qualifier.

Also, I'm not even sure to understand why we need the volatile qualifier
in the ioread() definitions from asm-generic/io.h...

Drivers wishing to pass volatile pointers to ioread() should probably use
a more low level api.

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
