From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 64/76] ARC: Add self to MAINTAINERS
Date: Tue, 22 Jan 2013 13:21:01 +0000
Message-ID: <50FE923D.5060108@imgtec.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-65-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:13053 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab3AVNVD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Jan 2013 08:21:03 -0500
In-Reply-To: <1358511930-7424-65-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On 18/01/13 12:25, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3105c48..05cdc99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7418,6 +7418,12 @@ F:	lib/swiotlb.c
>  F:	arch/*/kernel/pci-swiotlb.c
>  F:	include/linux/swiotlb.h
>  
> +SYNOPSYS ARC ARCHITECTURE
> +M:	Vineet Gupta <vgupta@synopsys.com>
> +L:	linux-snps-arc@vger.kernel.org

Is this set up? I don't see it at
http://vger.kernel.org/vger-lists.html

Incidentally, anybody know who to ask about setting up a new list?

Cheers
James

> +S:	Supported
> +F:	arch/arc/
> +
>  SYSV FILESYSTEM
>  M:	Christoph Hellwig <hch@infradead.org>
>  S:	Maintained
> 
