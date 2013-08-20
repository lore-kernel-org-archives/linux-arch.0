From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: Re: [RFC PATCH] drm/radeon: rework to new fence interface
Date: Tue, 20 Aug 2013 11:36:41 +0200
Message-ID: <521338A9.4040206@canonical.com>
References: <20130815124308.14812.58197.stgit@patser> <5211F0C5.2040705@canonical.com> <5212112C.70808@vodafone.de> <52127411.2010106@canonical.com> <52132AE0.4010702@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52132AE0.4010702@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
Cc: dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Op 20-08-13 10:37, Christian K=F6nig schreef:
> Am 19.08.2013 21:37, schrieb Maarten Lankhorst:
>> Op 19-08-13 14:35, Christian K=F6nig schreef:
>>> Am 19.08.2013 12:17, schrieb Maarten Lankhorst:
>>>> [SNIP]
>>>> @@ -190,25 +225,24 @@ void radeon_fence_process(struct radeon_devi=
ce *rdev, int ring)
>>>>            }
>>>>        } while (atomic64_xchg(&rdev->fence_drv[ring].last_seq, seq=
) > seq);
>>>>    -    if (wake) {
>>>> +    if (wake)
>>>>            rdev->fence_drv[ring].last_activity =3D jiffies;
>>>> -        wake_up_all(&rdev->fence_queue);
>>>> -    }
>>>> +    return wake;
>>>>    }
>>> Very bad idea, when sequence numbers change, you always want to wak=
e up the whole fence queue here.
>> Yes, and the callers of this function call wake_up_all or wake_up_al=
l_locked themselves, based on the return value..
>
> And as I said that's a very bad idea. The fence processing shouldn't =
be called with any locks held and should be self responsible for activa=
ting any waiters.
The call point (enable_signaling) only needs to know whether its own co=
unter has passed or not. This prevents the race where the counter
has elapsed, but the irq was not yet enabled.

I don't really care if enable_signaling updates last_seq or not, it onl=
y needs to check if it's own fence has been signaled after enabling sw_=
irqs.

>>
>>>> [SNIP]
>>>> +/**
>>>> + * radeon_fence_enable_signaling - enable signalling on fence
>>>> + * @fence: fence
>>>> + *
>>>> + * This function is called with fence_queue lock held, and adds a=
 callback
>>>> + * to fence_queue that checks if this fence is signaled, and if s=
o it
>>>> + * signals the fence and removes itself.
>>>> + */
>>>> +static bool radeon_fence_enable_signaling(struct fence *f)
>>>> +{
>>>> +    struct radeon_fence *fence =3D to_radeon_fence(f);
>>>> +
>>>> +    if (atomic64_read(&fence->rdev->fence_drv[fence->ring].last_s=
eq) >=3D fence->seq ||
>>>> +        !fence->rdev->ddev->irq_enabled)
>>>> +        return false;
>>>> +
>>> Do I get that right that you rely on IRQs to be enabled and working=
 here? Cause that would be a quite bad idea from the conceptual side.
>> For cross-device synchronization it would be nice to have working ir=
qs, it allows signalling fences faster,
>> and it allows for callbacks on completion to be called. For internal=
 usage it's no more required than it was before.
>
> That's a big NAK.
>
> The fence processing is actually very fine tuned to avoid IRQs and as=
 far as I can see you just leave them enabled by decrementing the atomi=
c from IRQ context. Additional to that we need allot of special handlin=
g in case of a hardware lockup here, which isn't done if you abuse the =
fence interface like this.
I think it's not needed to leave the irq enabled, it's a leftover from =
when I was debugging the mac and no interrupt occurred at all.

> Also your approach of leaking the IRQ context outside of the driver i=
s a very bad idea from the conceptual side. Please don't modify the fen=
ce interface at all and instead use the wait functions already exposed =
by radeon_fence.c. If you need some kind of signaling mechanism then wa=
it inside a workqueue instead.
The fence takes up the role of a single shot workqueue here. Manually r=
esetting the counter and calling wake_up_all would end up waking all ac=
tive fences, there's no special handling needed inside radeon for this.
The fence api does provide a synchronous wait function, but this causes=
 a stall of whomever waits on it. When I was testing this with intel I =
used the fence callback to poke a register in i915, this allowed it to =
not block until it hits the wait op in the command stream, and even the=
n only if the callback was not called first.

It's documented that the callbacks can be called from any context and w=
ill be called with irqs disabled, so nothing scary should be done. The =
kernel provides enough debug mechanisms to find any violators.
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP for example.

~Maarten
