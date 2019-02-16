From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: void __iomem *addr should be const
Date: Sat, 16 Feb 2019 21:49:21 +0100
Message-ID: <20190216204921.GB2173@behemoth.owl.eu.com.local>
References: <20190210122903.GA2400@behemoth.owl.eu.com.local>
 <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

> The const makes perfectly sense and we should have consistent state all
> over the place.

Thanks, I will submit a patch addressing this issue soon.

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
