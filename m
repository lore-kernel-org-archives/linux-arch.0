Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49766 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176AbaLKW2N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2014 17:28:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 3/5] pci: add pci_iomap_range
Date: Thu, 11 Dec 2014 23:27:54 +0100
Message-ID: <11102634.nzYXXfUH5X@wuerfel>
In-Reply-To: <1418326570-9541-4-git-send-email-mst@redhat.com>
References: <1418326570-9541-1-git-send-email-mst@redhat.com> <1418326570-9541-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, cornelia.huck@de.ibm.com, linux-arch@vger.kernel.org
Message-ID: <20141211222754.pMG4AhZuJAloMbeiwL2wOozAccR0LiAr8ChggctLtSg@z>

On Thursday 11 December 2014 21:37:34 Michael S. Tsirkin wrote:
>         if (flags & IORESOURCE_MEM) {
> -               if (flags & IORESOURCE_CACHEABLE)
> +               if (!force_nocache && (flags & IORESOURCE_CACHEABLE))
>                         return ioremap(start, len);
>                 return ioremap_nocache(start, len);
>         }
> 

ioremap is the same as ioremap_nocache, so this doesn't really make any
sense. IORESOURCE_CACHEABLE is practically only set for ROM bars, which
we rarely map.

	Arnd
