From: Matt Turner <mattst88@gmail.com>
Subject: Re: is alpha jensen support dead?
Date: Sun, 21 May 2017 22:33:33 -0700
Message-ID: <CAEdQ38F4aKXX4aDStWB5GEfCUfQ1Aige7i1_Pev8CMUtN02faw@mail.gmail.com>
References: <20170521085848.GA14559@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20170521085848.GA14559@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha <linux-alpha@vger.kernel.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, May 21, 2017 at 1:58 AM, Christoph Hellwig <hch@lst.de> wrote:
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
>
> Btw, how well is alpha working these days?  It looks like there hasn't
> been any maintainer activity for about two years.

I haven't had time for alpha stuff in quite a while.

I've never even had a Jensen, so it's never been important to me personally.
