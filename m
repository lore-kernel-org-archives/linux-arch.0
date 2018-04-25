Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42214 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeDYCDB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2018 22:03:01 -0400
Received: by mail-pg0-f44.google.com with SMTP id e12so12197160pgn.9
        for <linux-arch@vger.kernel.org>; Tue, 24 Apr 2018 19:03:01 -0700 (PDT)
Subject: Re: [PATCH 2/5] ide: kill ide_toggle_bounce
References: <20180424181625.22410-1-hch@lst.de>
 <20180424181625.22410-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5aaca0d3-417f-57f3-969f-b4c777c3fd48@kernel.dk>
Date: Tue, 24 Apr 2018 20:02:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180424181625.22410-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Message-ID: <20180425020256.AW0b6bp4otMwCL8ijCvF1ZRAGlLR0bxacgXUf34BkxQ@z>

On 4/24/18 12:16 PM, Christoph Hellwig wrote:
> ide_toggle_bounce did select various strange block bounce limits, including
> not bouncing at all as soon as an iommu is present in the system.  Given
> that the dma_map routines now handle any required bounce buffering except
> for ISA DMA, and the ide code already must handle either ISA DMA or highmem
> at least for iommu equipped systems we can get rid of the block layer
> bounce limit setting entirely.

Pretty sure I was the one to add this code, when highmem page IO was
enabled about two decades ago...

Outside of DMA, the issue was that the PIO code could not handle
highmem. That's not the case anymore, so this should be fine.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
