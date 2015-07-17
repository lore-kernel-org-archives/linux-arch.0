From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 1/7] atomics: add acquire/release/relaxed variants
 of some atomic operations
Date: Fri, 17 Jul 2015 13:19:54 -0400
Message-ID: <55A9393A.403@hp.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-2-git-send-email-will.deacon@arm.com> <55A84740.7080705@hp.com> <20150717094014.GD18994@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717094014.GD18994@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On 07/17/2015 05:40 AM, Will Deacon wrote:
> Hi Waiman,
>
> On Fri, Jul 17, 2015 at 01:07:28AM +0100, Waiman Long wrote:
>> On 07/16/2015 11:32 AM, Will Deacon wrote:
>>> +#ifndef atomic64_add_return_relaxed
>>> +#define  atomic64_add_return_relaxed	atomic64_add_return
>>> +#define  atomic64_add_return_acquire	atomic64_add_return
>>> +#define  atomic64_add_return_release	atomic64_add_return
>>> +
>>> +#else /* atomic64_add_return_relaxed */
>>> +
>>> +#ifndef atomic64_add_return_acquire
>>> +#define  atomic64_add_return_acquire(...)				\
>>> +	__atomic_op_acquire(long long, atomic64_add_return, __VA_ARGS__)
>>> +#endif
>>> +
>>> +#ifndef atomic64_add_return_release
>>> +#define  atomic64_add_return_release(...)				\
>>> +	__atomic_op_release(long long, atomic64_add_return, __VA_ARGS__)
>>> +#endif
>>> +
>>> +#ifndef atomic64_add_return
>>> +#define  atomic64_add_return(...)					\
>>> +	__atomic_op_fence(long long, atomic64_add_return, __VA_ARGS__)
>>> +#endif
>>> +#endif /* atomic64_add_return_relaxed */
>>> +
>> I have a minor nit. The atomic_add_return block is repeated with
>> "s/atomic_add_return/.../". Perhaps some more comments to delineate the
>> blocks more visibly will make this patch easier to read.
> Yeah, I agree that it's pretty hard going, but I don't have any great
> suggestions to solve that. I could add an extra blank line + comment
> before the start of each section, if you like? Example snippet below.
>
> Will
>
> --->8
>
> [...]
> #endif /* atomic_sub_return_relaxed */
>
>
> /* atomic_xchg_relaxed */
> #ifndef atomic_xchg_relaxed
> #define  atomic_xchg_relaxed		atomic_xchg
> #define  atomic_xchg_acquire		atomic_xchg
> #define  atomic_xchg_release		atomic_xchg
>
> #else /* atomic_xchg_relaxed */
>
> #ifndef atomic_xchg_acquire
> #define  atomic_xchg_acquire(...)					\
> 	__atomic_op_acquire(int, atomic_xchg, __VA_ARGS__)
> #endif
>
> #ifndef atomic_xchg_release
> #define  atomic_xchg_release(...)					\
> 	__atomic_op_release(int, atomic_xchg, __VA_ARGS__)
> #endif
>
> #ifndef atomic_xchg
> #define  atomic_xchg(...)						\
> 	__atomic_op_fence(int, atomic_xchg, __VA_ARGS__)
> #endif
> #endif /* atomic_xchg_relaxed */
>
>
> /* atomic_cmpxchg_relaxed */
> [...]
Something like

/* BEGIN atomc_xchg_relax */
...
/* END atomic_xchg_relax */

may help.

Alternatively, I sometimes add a line separator like

/*===================[ atomic_xchg_relax ]====================*/

Cheers,
Longman
