From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 5/6] reservation: add support for fences to enable
	cross-device synchronisation
Date: Mon, 17 Feb 2014 11:54:37 -0500
Message-ID: <CAF6AEGu6wMTg6HBgO3jjq+-muzOmN_BD0r9u26m=FWJWLJXyhA@mail.gmail.com>
References: <20140217155056.20337.25254.stgit@patser>
	<20140217155725.20337.52848.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140217155725.20337.52848.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 17, 2014 at 10:58 AM, Maarten Lankhorst
<maarten.lankhorst@canonical.com> wrote:
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>


> ---
>  include/linux/reservation.h |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/reservation.h b/include/linux/reservation.h
> index 813dae960ebd..92c4851b5a39 100644
> --- a/include/linux/reservation.h
> +++ b/include/linux/reservation.h
> @@ -6,7 +6,7 @@
>   * Copyright (C) 2012 Texas Instruments
>   *
>   * Authors:
> - * Rob Clark <rob.clark@linaro.org>
> + * Rob Clark <robdclark@gmail.com>
>   * Maarten Lankhorst <maarten.lankhorst@canonical.com>
>   * Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>   *
> @@ -40,22 +40,38 @@
>  #define _LINUX_RESERVATION_H
>
>  #include <linux/ww_mutex.h>
> +#include <linux/fence.h>
>
>  extern struct ww_class reservation_ww_class;
>
>  struct reservation_object {
>         struct ww_mutex lock;
> +
> +       struct fence *fence_excl;
> +       struct fence **fence_shared;
> +       u32 fence_shared_count, fence_shared_max;
>  };
>
>  static inline void
>  reservation_object_init(struct reservation_object *obj)
>  {
>         ww_mutex_init(&obj->lock, &reservation_ww_class);
> +
> +       obj->fence_shared_count = obj->fence_shared_max = 0;
> +       obj->fence_shared = NULL;
> +       obj->fence_excl = NULL;
>  }
>
>  static inline void
>  reservation_object_fini(struct reservation_object *obj)
>  {
> +       int i;
> +
> +       if (obj->fence_excl)
> +               fence_put(obj->fence_excl);
> +       for (i = 0; i < obj->fence_shared_count; ++i)
> +               fence_put(obj->fence_shared[i]);
> +
>         ww_mutex_destroy(&obj->lock);
>  }
>
>
