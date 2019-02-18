Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49421 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfBRUaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 15:30:10 -0500
Date: Mon, 18 Feb 2019 21:30:07 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: [PATCH 0/4] iomap: fix multiple consistency issues, interface
 cleanup
Message-ID: <20190218203007.GB18457@behemoth.owl.eu.com.local>
References: <cover.1550485787.git.hle@owl.eu.com>
 <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190218203007.Dmdeu26pIPD4VCGNniDDPV2LCwXjmmdq-tT6aMXnMr8@z>

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
