From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Date: Thu, 26 Jul 2018 11:13:23 +0200
Message-ID: <20180726091323.GB24209@lst.de>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com> <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
List-Id: linux-arch.vger.kernel.org

>  	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS

DMA_NONCOHERENT_OPS already selects DMA_DIRECT_OPS.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
