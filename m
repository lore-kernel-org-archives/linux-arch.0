Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35506 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeGZKZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Jul 2018 06:25:34 -0400
Date: Thu, 26 Jul 2018 11:13:23 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Message-ID: <20180726091323.GB24209@lst.de>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com> <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Message-ID: <20180726091323.P0lYF57ShTPG3ktH44JrGNZsrlKxN3YzBFlvS-H2yzY@z>

>  	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS

DMA_NONCOHERENT_OPS already selects DMA_DIRECT_OPS.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
