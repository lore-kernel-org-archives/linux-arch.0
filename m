From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH -mm 0/3] remove useless ISA_DMA_THRESHOLD
Date: Tue, 1 Jun 2010 20:24:52 +0200
Message-ID: <20100601182452.GA3564@kernel.dk>
References: <1275289144-28782-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:41389 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab0FASYx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Jun 2010 14:24:53 -0400
Content-Disposition: inline
In-Reply-To: <1275289144-28782-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: akpm@linux-foundation.org, James.Bottomley@suse.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, May 31 2010, FUJITA Tomonori wrote:
> This patchset removes useless ISA_DMA_THRESHOLD:
> 
> - ISA_DMA_THRESHOLD is irrelevant to the majority of architectures but
>   they have to define it.
> 
> - ISA_DMA_THRESHOLD definition is inconsistent on architectures; ISA
>   DMA addressing restriction, DMA addressing restriction or something
>   else.
> 
> - Everyone (except for SCSI) uses dma_mask instead of ancient
>   ISA_DMA_THRESHOLD.
> 
> Only SCSI uses ISA_DMA_THRESHOLD for ancient drivers with non-zero
> unchecked_isa_dma. We can safely remove ISA_DMA_THRESHOLD usage in
> SCSI. So we can clean up ISA_DMA_THRESHOLD on the whole tree.

Looks good. James, it's probably easier if I just carry this patch set.

-- 
Jens Axboe
