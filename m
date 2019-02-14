From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6/8] initramfs: move the legacy keepinitrd parameter to
 core code
Date: Thu, 14 Feb 2019 16:56:43 +0000
Message-ID: <20190214165642.GB20349@C02TF0J2HF1T.local>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213174621.29297-7-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
