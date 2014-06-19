From: Rob Clark <robdclark@gmail.com>
Subject: Re: [REPOST PATCH 1/8] fence: dma-buf cross-device synchronization
 (v17)
Date: Thu, 19 Jun 2014 14:52:56 -0400
Message-ID: <CAF6AEGu0fE0+=WPZ4WNprUGmz=hxTFson_MYfQbJe_uV+kOkUQ@mail.gmail.com>
References: <20140618102957.15728.43525.stgit@patser>
 <20140618103653.15728.4942.stgit@patser>
 <20140619011327.GC10921@kroah.com>
 <CAF6AEGv4Ms+zsrEtpA10bGq04LnRjzVb925co49eVxh4ugkd=A@mail.gmail.com>
 <20140619170059.GA1224@kroah.com>
 <CAF6AEGuXKw1w=outX+QgFE2XZxV8c6pyhORL+mRp4uZR8Jnq7g@mail.gmail.com>
 <20140619181918.GA24155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140619181918.GA24155@kroah.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 19, 2014 at 2:19 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 19, 2014 at 01:45:30PM -0400, Rob Clark wrote:
>> On Thu, Jun 19, 2014 at 1:00 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Jun 19, 2014 at 10:00:18AM -0400, Rob Clark wrote:
>> >> On Wed, Jun 18, 2014 at 9:13 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >> > On Wed, Jun 18, 2014 at 12:36:54PM +0200, Maarten Lankhorst wrote:
>> >> >> +#define CREATE_TRACE_POINTS
>> >> >> +#include <trace/events/fence.h>
>> >> >> +
>> >> >> +EXPORT_TRACEPOINT_SYMBOL(fence_annotate_wait_on);
>> >> >> +EXPORT_TRACEPOINT_SYMBOL(fence_emit);
>> >> >
>> >> > Are you really willing to live with these as tracepoints for forever?
>> >> > What is the use of them in debugging?  Was it just for debugging the
>> >> > fence code, or for something else?
>> >> >
>> >> >> +/**
>> >> >> + * fence_context_alloc - allocate an array of fence contexts
>> >> >> + * @num:     [in]    amount of contexts to allocate
>> >> >> + *
>> >> >> + * This function will return the first index of the number of fences allocated.
>> >> >> + * The fence context is used for setting fence->context to a unique number.
>> >> >> + */
>> >> >> +unsigned fence_context_alloc(unsigned num)
>> >> >> +{
>> >> >> +     BUG_ON(!num);
>> >> >> +     return atomic_add_return(num, &fence_context_counter) - num;
>> >> >> +}
>> >> >> +EXPORT_SYMBOL(fence_context_alloc);
>> >> >
>> >> > EXPORT_SYMBOL_GPL()?  Same goes for all of the exports in here.
>> >> > Traditionally all of the driver core exports have been with this
>> >> > marking, any objection to making that change here as well?
>> >>
>> >> tbh, I prefer EXPORT_SYMBOL()..  well, I'd prefer even more if there
>> >> wasn't even a need for EXPORT_SYMBOL_GPL(), but sadly it is a fact of
>> >> life.  We already went through this debate once with dma-buf.  We
>> >> aren't going to change $evil_vendor's mind about non-gpl modules.  The
>> >> only result will be a more flugly convoluted solution (ie. use syncpt
>> >> EXPORT_SYMBOL() on top of fence EXPORT_SYMBOL_GPL()) just as a
>> >> workaround, with the result that no-one benefits.
>> >
>> > It has been proven that using _GPL() exports have caused companies to
>> > release their code "properly" over the years, so as these really are
>> > Linux-only apis, please change them to be marked this way, it helps
>> > everyone out in the end.
>>
>> Well, maybe that is the true in some cases.  But it certainly didn't
>> work out that way for dma-buf.  And I think the end result is worse.
>>
>> I don't really like coming down on the side of EXPORT_SYMBOL() instead
>> of EXPORT_SYMBOL_GPL(), but if we do use EXPORT_SYMBOL_GPL() then the
>> result will only be creative workarounds using the _GPL symbols
>> indirectly by whatever is available via EXPORT_SYMBOL().  I don't
>> really see how that will be better.
>
> You are saying that you _know_ companies will violate our license, so
> you should just "give up"?  And how do you know people aren't working on
> preventing those "indirect" usages as well?  :)

Well, all I know is what happened with dmabuf.  This seems like the
exact same scenario (same vendor, same driver, same use-case).

Not really sure how we could completely prevent indirect usage, given
that drm core and many of the drivers are dual MIT/GPL.   (But ofc,
IANAL.)

> Sorry, I'm not going to give up here, again, it has proven to work in
> the past in changing the ways of _very_ large companies, why stop now?

In the general case, I would agree.  But in this specific case, I am
not very optimistic.

That said, it isn't really my loss if it is _GPL()..  I don't have to
use or support that particular driver.  But given that we have some
history from the same debate with dma-buf, I think it is pretty easy
to infer the result from making fence EXPORT_SYMBOL_GPL().

BR,
-R

> thanks,
>
> greg k-h
