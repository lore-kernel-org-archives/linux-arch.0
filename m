Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502775AbfBNQ4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 11:56:49 -0500
Date: Thu, 14 Feb 2019 16:56:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6/8] initramfs: move the legacy keepinitrd parameter to
 core code
Message-ID: <20190214165642.GB20349@C02TF0J2HF1T.local>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213174621.29297-7-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190214165643.PmYKEYNi1FiVn07KXjOAT5O35FjkkbST_p5rGGtILxw@z>

On Wed, Feb 13, 2019 at 06:46:19PM +0100, Christoph Hellwig wrote:
> No need to handle the freeing disable in arch code when we already
> have a core hook (and a different name for the option) for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/Kconfig             |  7 +++++++
>  arch/arm/Kconfig         |  1 +
>  arch/arm/mm/init.c       | 25 ++++++-------------------
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/mm/init.c     | 17 ++---------------
>  arch/unicore32/Kconfig   |  1 +
>  arch/unicore32/mm/init.c | 14 +-------------
>  init/initramfs.c         |  9 +++++++++
>  8 files changed, 28 insertions(+), 47 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
