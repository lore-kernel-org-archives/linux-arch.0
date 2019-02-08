From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/3] drm: tweak header name
Date: Fri, 8 Feb 2019 09:56:59 +0100
Message-ID: <20190208085659.GI23159@phenom.ffwll.local>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-4-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-4-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:58AM -0500, Michael S. Tsirkin wrote:
> Use linux/mman.h to make sure we get all mmap flags we need.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

drmP.h is seriously deprecated (and a monster mess). If this fixes
anything, I think would be better to include the right header in the right
places, and leave drmP.h to die quietly ...

What exactly does this fix?
-Daniel

> ---
>  include/drm/drmP.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index bdb0d5548f39..a3184416ddc5 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -57,8 +57,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/dma-fence.h>
>  #include <linux/module.h>
> -
> -#include <asm/mman.h>
> +#include <linux/mman.h>
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
>  
> -- 
> MST
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
