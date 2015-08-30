From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH 3/9] amdkfd: use <linux/mman.h> instead of <uapi/asm-generic/mman-common.h>
Date: Sun, 30 Aug 2015 12:43:19 +0300
Message-ID: <CAFCwf13VzCeJsKtf5aOj0QTT6ciV=7PvPpeezyUjje3rOKQKfg@mail.gmail.com>
References: <1440746842-19029-1-git-send-email-hch@lst.de> <1440746842-19029-4-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440746842-19029-4-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 28, 2015 at 10:27 AM, Christoph Hellwig <hch@lst.de> wrote:
>
> The latter is a default version of <asm/mman.h> and not for driver use.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index c991973..c6a1b4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -31,7 +31,7 @@
>  #include <uapi/linux/kfd_ioctl.h>
>  #include <linux/time.h>
>  #include <linux/mm.h>
> -#include <uapi/asm-generic/mman-common.h>
> +#include <linux/mman.h>
>  #include <asm/processor.h>
>  #include "kfd_priv.h"
>  #include "kfd_device_queue_manager.h"
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 35b9875..2b65510 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -33,7 +33,7 @@
>  #include <linux/time.h>
>  #include "kfd_priv.h"
>  #include <linux/mm.h>
> -#include <uapi/asm-generic/mman-common.h>
> +#include <linux/mman.h>
>  #include <asm/processor.h>
>
>  /*
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Thanks,
Applied to my -next-fixes tree

     Oded
