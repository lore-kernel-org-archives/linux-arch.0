From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: is alpha jensen support dead?
Date: Mon, 22 May 2017 15:50:02 +1000
Message-ID: <87lgppsanp.fsf@concordia.ellerman.id.au>
References: <20170521085848.GA14559@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20170521085848.GA14559@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Hi all,
>
> it seems like the Alpha Jense build (the only one using pci-noop.c)
> and thus being a different build than all the later PCI capable
> system has been broken since at least:
>
> commit 6aca0503847f6329460b15b3ab2b0e30bb752793
> Author: Christian Borntraeger <borntraeger@de.ibm.com>
> Date:   Tue Feb 2 21:46:33 2016 -0800
>
>     alpha/dma: use common noop dma ops
>
> which switches pci-noop.c to use generic code, but fat fingered a symbol
> and didn't wire up the Kconfig.
>
> Is there any value in keeping it alive?  Especially as there probably
> isn't any build coverage..

We still build the defconfig FWIW:

  http://kisskb.ellerman.id.au/kisskb/target/2499/
  http://kisskb.ellerman.id.au/kisskb/target/2494/

cheers
