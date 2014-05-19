From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [RFC PATCH 2/2 with seqcount v3] reservation: add suppport for
 read-only access using rcu
Date: Mon, 19 May 2014 15:43:38 +0100
Message-ID: <537A189A.2030407@vmware.com>
References: <20140409144239.26648.57918.stgit@patser>
 <20140409144831.26648.79163.stgit@patser> <53465A53.1090500@vmware.com>
 <53466D63.8080808@canonical.com> <53467B93.3000402@vmware.com>
 <5346B212.8050202@canonical.com> <5347A9FD.2070706@vmware.com>
 <5347B4E5.6090901@canonical.com> <5347BFC9.3020503@vmware.com>
 <53482FF1.1090406@canonical.com> <534843EA.6060602@vmware.com>
 <534B9165.4000101@canonical.com> <534B921B.4080504@vmware.com>
 <5357A0DE.7030305@canonical.com> <537A0A5D.6090909@vmware.com>
 <537A1180.2010109@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <537A1180.2010109@canonical.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/19/2014 03:13 PM, Maarten Lankhorst wrote:
> op 19-05-14 15:42, Thomas Hellstrom schreef:
>> Hi, Maarten!
>>
>> Some nitpicks, and that krealloc within rcu lock still worries me.
>> Otherwise looks good.
>>
>> /Thomas
>>
>>
>>
>> On 04/23/2014 12:15 PM, Maarten Lankhorst wrote:
>>> @@ -55,8 +60,8 @@ int reservation_object_reserve_shared(struct
>>> reservation_object *obj)
>>>               kfree(obj->staged);
>>>               obj->staged = NULL;
>>>               return 0;
>>> -        }
>>> -        max = old->shared_max * 2;
>>> +        } else
>>> +            max = old->shared_max * 2;
>> Perhaps as a separate reformatting patch?
> I'll fold it in to the patch that added
> reservation_object_reserve_shared.
>>> +
>>> +int reservation_object_get_fences_rcu(struct reservation_object *obj,
>>> +                      struct fence **pfence_excl,
>>> +                      unsigned *pshared_count,
>>> +                      struct fence ***pshared)
>>> +{
>>> +    unsigned shared_count = 0;
>>> +    unsigned retry = 1;
>>> +    struct fence **shared = NULL, *fence_excl = NULL;
>>> +    int ret = 0;
>>> +
>>> +    while (retry) {
>>> +        struct reservation_object_list *fobj;
>>> +        unsigned seq;
>>> +
>>> +        seq = read_seqcount_begin(&obj->seq);
>>> +
>>> +        rcu_read_lock();
>>> +
>>> +        fobj = rcu_dereference(obj->fence);
>>> +        if (fobj) {
>>> +            struct fence **nshared;
>>> +
>>> +            shared_count = ACCESS_ONCE(fobj->shared_count);
>> ACCESS_ONCE() shouldn't be needed inside the seqlock?
> Yes it is, shared_count may be increased, leading to potential
> different sizes for krealloc and memcpy
> if the ACCESS_ONCE is removed. I could use shared_max here instead,
> which stays the same,
> but it would waste more memory.

OK.
>
>>> +            nshared = krealloc(shared, sizeof(*shared) *
>>> shared_count, GFP_KERNEL);
>> Again, krealloc should be a sleeping function, and not suitable within a
>> RCU read lock? I still think this krealloc should be moved to the start
>> of the retry loop, and we should start with a suitable guess of
>> shared_count (perhaps 0?) It's not like we're going to waste a lot of
>> memory....
> But shared_count is only known when holding the rcu lock.
>
> What about this change?

Sure. That should work.

/Thomas

>
> @@ -254,16 +254,27 @@ int reservation_object_get_fences_rcu(struct
> reservation_object *obj,
>          fobj = rcu_dereference(obj->fence);
>          if (fobj) {
>              struct fence **nshared;
> +            size_t sz;
>  
>              shared_count = ACCESS_ONCE(fobj->shared_count);
> -            nshared = krealloc(shared, sizeof(*shared) *
> shared_count, GFP_KERNEL);
> +            sz = sizeof(*shared) * shared_count;
> +
> +            nshared = krealloc(shared, sz,
> +                       GFP_NOWAIT | __GFP_NOWARN);
>              if (!nshared) {
> +                rcu_read_unlock();
> +                nshared = krealloc(shared, sz, GFP_KERNEL)
> +                if (nshared) {
> +                    shared = nshared;
> +                    continue;
> +                }
> +
>                  ret = -ENOMEM;
> -                shared_count = retry = 0;
> -                goto unlock;
> +                shared_count = 0;
> +                break;
>              }
>              shared = nshared;
> -            memcpy(shared, fobj->shared, sizeof(*shared) *
> shared_count);
> +            memcpy(shared, fobj->shared, sz);
>          } else
>              shared_count = 0;
>          fence_excl = rcu_dereference(obj->fence_excl);
>
>
>>> +
>>> +        /*
>>> +         * There could be a read_seqcount_retry here, but nothing
>>> cares
>>> +         * about whether it's the old or newer fence pointers that are
>>> +         * signale. That race could still have happened after checking
>> Typo.
> Oops
