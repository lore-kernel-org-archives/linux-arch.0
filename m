From: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
Subject: Re: [RFC PATCH] drm/radeon: rework to new fence interface
Date: Mon, 19 Aug 2013 14:35:56 +0200
Message-ID: <5212112C.70808@vodafone.de>
References: <20130815124308.14812.58197.stgit@patser> <5211F0C5.2040705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5211F0C5.2040705@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Am 19.08.2013 12:17, schrieb Maarten Lankhorst:
> [SNIP]
> @@ -190,25 +225,24 @@ void radeon_fence_process(struct radeon_device *rdev, int ring)
>   		}
>   	} while (atomic64_xchg(&rdev->fence_drv[ring].last_seq, seq) > seq);
>   
> -	if (wake) {
> +	if (wake)
>   		rdev->fence_drv[ring].last_activity = jiffies;
> -		wake_up_all(&rdev->fence_queue);
> -	}
> +	return wake;
>   }

Very bad idea, when sequence numbers change, you always want to wake up 
the whole fence queue here.

> [SNIP]
> +/**
> + * radeon_fence_enable_signaling - enable signalling on fence
> + * @fence: fence
> + *
> + * This function is called with fence_queue lock held, and adds a callback
> + * to fence_queue that checks if this fence is signaled, and if so it
> + * signals the fence and removes itself.
> + */
> +static bool radeon_fence_enable_signaling(struct fence *f)
> +{
> +	struct radeon_fence *fence = to_radeon_fence(f);
> +
> +	if (atomic64_read(&fence->rdev->fence_drv[fence->ring].last_seq) >= fence->seq ||
> +	    !fence->rdev->ddev->irq_enabled)
> +		return false;
> +

Do I get that right that you rely on IRQs to be enabled and working 
here? Cause that would be a quite bad idea from the conceptual side.

> +	radeon_irq_kms_sw_irq_get(fence->rdev, fence->ring);
> +
> +	if (__radeon_fence_process(fence->rdev, fence->ring))
> +		wake_up_all_locked(&fence->rdev->fence_queue);
> +
> +	/* did fence get signaled after we enabled the sw irq? */
> +	if (atomic64_read(&fence->rdev->fence_drv[fence->ring].last_seq) >= fence->seq) {
> +		radeon_irq_kms_sw_irq_put(fence->rdev, fence->ring);
> +		return false;
> +	}
> +
> +	fence->fence_wake.flags = 0;
> +	fence->fence_wake.private = NULL;
> +	fence->fence_wake.func = radeon_fence_check_signaled;
> +	__add_wait_queue(&fence->rdev->fence_queue, &fence->fence_wake);
> +	fence_get(f);
> +
> +	return true;
> +}
> +
>   /**
>    * radeon_fence_signaled - check if a fence has signaled
>    *
>

Christian.
