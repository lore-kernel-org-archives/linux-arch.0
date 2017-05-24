From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: is alpha jensen support dead?
Date: Wed, 24 May 2017 11:16:01 +0200
Message-ID: <11c44626-d496-ec77-c294-1d734d6125aa@de.ibm.com>
References: <20170521085848.GA14559@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521085848.GA14559@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/21/2017 10:58 AM, Christoph Hellwig wrote:
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

Hi Christoph,

are you providing a fix (or a jensen removal) or do you expect a fix from me?


> which switches pci-noop.c to use generic code, but fat fingered a symbol
> and didn't wire up the Kconfig.
> 
> Is there any value in keeping it alive?  Especially as there probably
> isn't any build coverage..
> 
> Btw, how well is alpha working these days?  It looks like there hasn't
> been any maintainer activity for about two years.
> 
