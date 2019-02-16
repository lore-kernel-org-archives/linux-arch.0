From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: void __iomem *addr should be const
Date: Sat, 16 Feb 2019 20:16:39 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
References: <20190210122903.GA2400@behemoth.owl.eu.com.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190210122903.GA2400@behemoth.owl.eu.com.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, 10 Feb 2019, Hugo Lefeuvre wrote:
> __iomem *addr seems to lack a const qualifier in the ioread* definitions
> from include/asm-generic/iomap.h (other definitions such as
> asm-generic/io.h do have the const).
> 
> This issue was briefly discussed a while ago[0] but the outcome is not
> quite clear to me. Should I submit a patch addressing this issue or is it
> a definitive wontfix?
> 
> This issue triggers warnings in my current work but I would like to avoid
> dropping the const if possible.

The const makes perfectly sense and we should have consistent state all
over the place.

Thanks,

	tglx
