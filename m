From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] dma-mapping: Provide write-combine allocations
Date: Fri, 1 Aug 2014 14:55:18 +0200
Message-ID: <201408011455.18991.arnd@arndb.de>
References: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55731 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbaHAM4E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Aug 2014 08:56:04 -0400
In-Reply-To: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 27 June 2014, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Provide an implementation for dma_{alloc,free,mmap}_writecombine() when
> the architecture supports DMA attributes.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'd suggest this gets merged through Russell's tree. Please add to the
patch tracker with my Ack.

	Arnd
