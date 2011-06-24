Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 8bytes.org ([88.198.83.132]:60556 "EHLO 8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab1FXIo4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2011 04:44:56 -0400
Date: Fri, 24 Jun 2011 10:39:09 +0200
From: 'Joerg Roedel' <joro@8bytes.org>
Subject: Re: [Linaro-mm-sig] [PATCH 3/8] ARM: dma-mapping: use
	asm-generic/dma-mapping-common.h
Message-ID: <20110624083909.GB29299@8bytes.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <1308556213-24970-4-git-send-email-m.szyprowski@samsung.com> <BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com> <002501cc3008$f000d600$d0028200$%szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501cc3008$f000d600$d0028200$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: 'KyongHo Cho' <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>
Message-ID: <20110624083909.wNDGKeTDXS5GvmuOd1O7eGwypNBqiSF30sskY_Ufdps@z>

On Tue, Jun 21, 2011 at 01:47:03PM +0200, Marek Szyprowski wrote:
> > I also think that it is better to attach and to detach dma_map_ops
> > dynamically.
> 
> What's the point of such operations? Why do you want to change dma
> mapping methods in runtime?

That is dangerous. You have to make sure that there are no mappings
granted to the the device driver before changing the dma_ops of a device
at runtime. Otherwise existing mappings for a device may disappear and
confuse the driver and the device.

Joerg

