From: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
Subject: Re: [RFC PATCH] drm/radeon: rework to new fence interface
Date: Tue, 20 Aug 2013 10:37:52 +0200
Message-ID: <52132AE0.4010702@vodafone.de>
References: <20130815124308.14812.58197.stgit@patser> <5211F0C5.2040705@canonical.com> <5212112C.70808@vodafone.de> <52127411.2010106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52127411.2010106@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Am 19.08.2013 21:37, schrieb Maarten Lankhorst:
> Op 19-08-13 14:35, Christian K=F6nig schreef:
>> Am 19.08.2013 12:17, schrieb Maarten Lankhorst:
>>> [SNIP]
>>> @@ -190,25 +225,24 @@ void radeon_fence_process(struct radeon_devic=
e *rdev, int ring)
>>>            }
>>>        } while (atomic64_xchg(&rdev->fence_drv[ring].last_seq, seq)=
 > seq);
>>>    -    if (wake) {
>>> +    if (wake)
>>>            rdev->fence_drv[ring].last_activity =3D jiffies;
>>> -        wake_up_all(&rdev->fence_queue);
>>> -    }
>>> +    return wake;
>>>    }
>> Very bad idea, when sequence numbers change, you always want to wake=
 up the whole fence queue here.
> Yes, and the callers of this function call wake_up_all or wake_up_all=
_locked themselves, based on the return value..

And as I said that's a very bad idea. The fence processing shouldn't be=
=20
called with any locks held and should be self responsible for activatin=
g=20
any waiters.

>
>>> [SNIP]
>>> +/**
>>> + * radeon_fence_enable_signaling - enable signalling on fence
>>> + * @fence: fence
>>> + *
>>> + * This function is called with fence_queue lock held, and adds a =
callback
>>> + * to fence_queue that checks if this fence is signaled, and if so=
 it
>>> + * signals the fence and removes itself.
>>> + */
>>> +static bool radeon_fence_enable_signaling(struct fence *f)
>>> +{
>>> +    struct radeon_fence *fence =3D to_radeon_fence(f);
>>> +
>>> +    if (atomic64_read(&fence->rdev->fence_drv[fence->ring].last_se=
q) >=3D fence->seq ||
>>> +        !fence->rdev->ddev->irq_enabled)
>>> +        return false;
>>> +
>> Do I get that right that you rely on IRQs to be enabled and working =
here? Cause that would be a quite bad idea from the conceptual side.
> For cross-device synchronization it would be nice to have working irq=
s, it allows signalling fences faster,
> and it allows for callbacks on completion to be called. For internal =
usage it's no more required than it was before.

That's a big NAK.

The fence processing is actually very fine tuned to avoid IRQs and as=20
far as I can see you just leave them enabled by decrementing the atomic=
=20
from IRQ context. Additional to that we need allot of special handling=20
in case of a hardware lockup here, which isn't done if you abuse the=20
fence interface like this.

Also your approach of leaking the IRQ context outside of the driver is =
a=20
very bad idea from the conceptual side. Please don't modify the fence=20
interface at all and instead use the wait functions already exposed by=20
radeon_fence.c. If you need some kind of signaling mechanism then wait=20
inside a workqueue instead.

Christian.
