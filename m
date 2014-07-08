From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 0/9] Updated fence patch series
Date: Tue, 8 Jul 2014 20:22:11 +0530
Message-ID: <CAO_48GHwJ4EuCKgLmZhEaEQqS9e7EVZP3hsivhRwLCNFhzAQVA@mail.gmail.com>
References: <20140701103432.12718.82795.stgit@patser> <20140702053758.GA7578@kroah.com>
 <CAKMK7uHZQjQ2m7KE22kTRVs-NtGguHREk24pSJiLbN7EoQLZ=g@mail.gmail.com>
 <20140707173052.GA8693@kroah.com> <20140708134427.GG17271@phenom.ffwll.local> <20140708143912.GA3436@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37244 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaGHOwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jul 2014 10:52:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so6503617obc.23
        for <linux-arch@vger.kernel.org>; Tue, 08 Jul 2014 07:52:31 -0700 (PDT)
In-Reply-To: <20140708143912.GA3436@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "Clark, Rob" <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On 8 July 2014 20:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 08, 2014 at 03:44:27PM +0200, Daniel Vetter wrote:
>> On Mon, Jul 07, 2014 at 10:30:52AM -0700, Greg KH wrote:
>> > On Mon, Jul 07, 2014 at 03:23:17PM +0200, Daniel Vetter wrote:
>> > > On Wed, Jul 2, 2014 at 7:37 AM, Greg KH <gregkh@linuxfoundation.=
org> wrote:
>> > > >> Android can expose fences to userspace. It's possible to make=
 the new fence
>> > > >> mechanism expose the same fences to userspace by changing syn=
c_fence_create
>> > > >> to take a struct fence instead of a struct sync_pt. No other =
change is needed,
>> > > >> because only the fence parts of struct sync_pt are used. But =
because the
>> > > >> userspace fences are a separate problem and I haven't really =
looked at it yet
>> > > >> I feel it should stay in staging, for now.
>> > > >
>> > > > Ok, that's reasonable.
>> > > >
>> > > > At first glance, this all looks "sane" to me, any objection fr=
om anyone
>> > > > if I merge this through my driver-core tree for 3.17?
>> > >
>> > > Ack from my side fwiw.
>> >
>> > Thanks, I'll queue it up later today.
>>
>> btw should we add you as a (co)maintainer for driver/core/dma-buf si=
nce
>> you seem to want to keep a closer tab on what the insane gfx folks a=
re up
>> to in there?
>
> Sure, why not, what's one more maintainership...
>
> Oh, does that mean you want me to be the one collecting the patches a=
nd
> forwarding them on to Linus?  If so, that's fine, I can easily do tha=
t
> as well due to my infrastructure being set up for it.
>
If you're ok, I could continue to do the collecting / forwarding
business - I guess Daniel meant more from the 'not miss patches that
need review'!

Upto you!
> thanks,
>
> greg k-h
Thanks and best regards,
~Sumit


--=20
Thanks and regards,

Sumit Semwal
Graphics Engineer - Graphics working group
Linaro.org =E2=94=82 Open source software for ARM SoCs
