From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 22:26:18 -0400
Message-ID: <483F65CA.4050507@rtr.ca>
References: <1212092282.28403.107.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2806 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbYE3C0V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 22:26:21 -0400
In-Reply-To: <1212092282.28403.107.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/ata/pdc_adma.c   |   12 ++++++------
>  drivers/ata/sata_qstor.c |   12 +++++-------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> index be53545..162eecb 100644
> --- a/drivers/ata/pdc_adma.c
> +++ b/drivers/ata/pdc_adma.c
> @@ -284,11 +284,11 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
>  		u32 len;
>  
>  		addr = (u32)sg_dma_address(sg);
> -		*(__le32 *)(buf + i) = cpu_to_le32(addr);
> +		put_le32(addr, (__le32 *)(buf + i));
..

I don't get it.

What's the point here?
