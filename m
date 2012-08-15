From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 14/31] arm64: DMA mapping API
Date: Tue, 14 Aug 2012 17:40:06 -0700
Message-ID: <20120815004006.GG19607@quad.lixom.net>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-15-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1344966752-16102-15-git-send-email-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi,


On Tue, Aug 14, 2012 at 06:52:15PM +0100, Catalin Marinas wrote:
> This patch adds support for the DMA mapping API. It uses dma_map_ops for
> flexibility and it currently supports swiotlb. This patch could be
> simplified further if the DMA accesses are coherent (not mandated by the
> architecture) or if corresponding hooks are placed in the generic
> swiotlb code to deal with cache maintenance.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/dma-mapping.h |  124 ++++++++++++++++++++
>  arch/arm64/mm/dma-mapping.c          |  208 ++++++++++++++++++++++++++++++++++
>  2 files changed, 332 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/include/asm/dma-mapping.h
>  create mode 100644 arch/arm64/mm/dma-mapping.c
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> new file mode 100644
> index 0000000..538f4b4
> --- /dev/null
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_DMA_MAPPING_H
> +#define __ASM_DMA_MAPPING_H
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm-generic/dma-coherent.h>
> +
> +#define ARCH_HAS_DMA_GET_REQUIRED_MASK
> +
> +extern struct dma_map_ops *dma_ops;
> 
> +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> +{
> +	if (unlikely(!dev) || !dev->archdata.dma_ops)
> +		return dma_ops;
> +	else
> +		return dev->archdata.dma_ops;
> +}

Does it make sense to add the concept of a global dma ops on arm64,
instead of requiring the dma ops pointer per device similar to how
some other platforms do it (including powerpc)? For devices that lack
archdata.dma_ops, dma_supported() should return 0 (and the other ops
should return error).



-Olof
