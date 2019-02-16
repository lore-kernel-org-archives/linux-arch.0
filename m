Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbfBPTQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Feb 2019 14:16:42 -0500
Date: Sat, 16 Feb 2019 20:16:39 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: void __iomem *addr should be const
In-Reply-To: <20190210122903.GA2400@behemoth.owl.eu.com.local>
Message-ID: <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
References: <20190210122903.GA2400@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190216191639.xxcXCdDOGRVdXsMFguAyrHFOB18hFQ_C7XJ9YxntbUM@z>

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
