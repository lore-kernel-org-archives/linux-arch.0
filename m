From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH-RFC 1/2 v2] tile: don't panic on iomap
Date: Wed, 30 Nov 2011 14:23:43 -0500
Message-ID: <4ED682BF.200@tilera.com>
References: <V0IAN#zrMHA.5780@exchange1.tad.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.75]:19801 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab1K3TXo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Nov 2011 14:23:44 -0500
In-Reply-To: <V0IAN#zrMHA.5780@exchange1.tad.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Paul Mundt <lethal@linux-sh.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>

On 11/30/2011 4:08 AM, Michael S. Tsirkin wrote:
> I think panic on iomap is there just for debugging.
> If we return NULL instead, the generic pci_iomap will
> do the same thing as the custom one that tile currently has
> (that is, return NULL on an IO BAR)
> so tile won't need to roll its own anymore.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Note: the other patch in the series is unchanged.
> Changes from v1:
>   - tweaked pr_info message
>
>  arch/tile/include/asm/io.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
> index c9ea165..d2152de 100644
> --- a/arch/tile/include/asm/io.h
> +++ b/arch/tile/include/asm/io.h
> @@ -204,7 +204,8 @@ static inline long ioport_panic(void)
>  
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
>  {
> -	return (void __iomem *) ioport_panic();
> +	pr_info("ioport_map: mapping IO resources is unsupported on tile.\n");
> +	return NULL;
>  }
>  
>  static inline void ioport_unmap(void __iomem *addr)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

I agree with Arnd that this isn't necessarily the best solution (build-time
failures are always preferable) but given that he's planning some more
ambitious work, this seems reasonable to me.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
