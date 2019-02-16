Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59267 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfBPUtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Feb 2019 15:49:24 -0500
Date: Sat, 16 Feb 2019 21:49:21 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: void __iomem *addr should be const
Message-ID: <20190216204921.GB2173@behemoth.owl.eu.com.local>
References: <20190210122903.GA2400@behemoth.owl.eu.com.local>
 <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190216204921.2KoeSxXdT1ldg9DYErFnMjvI36I3JsPYP6VNx7sXB7g@z>

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
