Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lithops.sigma-star.at ([195.201.40.130]:47324 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfKZQFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 11:05:00 -0500
Date: Tue, 26 Nov 2019 17:04:55 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <293078386.98317.1574784295793.JavaMail.zimbra@nod.at>
In-Reply-To: <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com> <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com> <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net> <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at> <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net> <243342257.98153.1574762974057.JavaMail.zimbra@nod.at> <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net> <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tavi purdila <tavi.purdila@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Hajime Tazaki <thehajime@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>, linux-um <linux-um@lists.infradead.org>, retrage01 <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, pscollins <pscollins@google.com>, sigmaepsilon92 <sigmaepsilon92@gmail.com>, liuyuan <liuyuan@google.com>, anton ivanov <anton.ivanov@cambridgegreys.com>

----- Ursprüngliche Mail -----
> Von: "tavi purdila" <tavi.purdila@gmail.com>
> An: "Johannes Berg" <johannes@sipsolutions.net>
> CC: "richard" <richard@nod.at>, "Hajime Tazaki" <thehajime@gmail.com>, "linux-arch" <linux-arch@vger.kernel.org>, "cem"
> <cem@freebsd.org>, "linux-um" <linux-um@lists.infradead.org>, "retrage01" <retrage01@gmail.com>, "linux-kernel-library"
> <linux-kernel-library@freelists.org>, "pscollins" <pscollins@google.com>, "sigmaepsilon92" <sigmaepsilon92@gmail.com>,
> "liuyuan" <liuyuan@google.com>
> Gesendet: Dienstag, 26. November 2019 11:42:01
> Betreff: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices

> On Tue, Nov 26, 2019 at 12:16 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
>>
>> On Tue, 2019-11-26 at 11:09 +0100, Richard Weinberger wrote:
>> > ----- Ursprüngliche Mail -----
>> > > > My point is that UML and LKL should try to do use the same concept/code
>> > > > regarding virtio. At the end of day both use virtual devices which use
>> > > > facilities from the host.
>> > > > If this is really not possible it needs a good explanation.
>> > >
>> > > I think it isn't possible, unless you use vhost-user over a unix domain
>> > > socket internally to talk between the kernel (virtio_uml) and hypervisor
>> > > (device) components.
>> > >
>> > > In virtio_uml, the device implementation is assumed to be a separate
>> > > process with a vhost-user connection. Here in LKL, the virtio device is
>> > > part of the "hypervisor", i.e. in the same process.
>> >
>> > Exactly, currently UML and LKL solve same things differently, but do we need to?
>>
>> It's not the same thing though :-)
>>
>> UML right now doesn't have or support virtio devices in the built-in
>> hypervisor, what we wanted to use virtio for was explicitly for the
>> vhost-user devices.
>>
>> LKL clearly wants to have device implementations in the hypervisor,
>> perhaps for networking or console etc.? That _might_ be useful since it
>> makes the device implementation more general, unlike the UML approach
>> where all devices come with a kernel- and user-side and are special
>> drivers in the kernel, vs. general virtio drivers.
>>
> 
> That is correct. Initially we used the same UML model, with dedicated
> drivers for LKL, and later switched to using the built-in virtio
> drivers (so far for network and block devices).

Can you please point out a little further why UML's net or block drivers
are not usable for LKL?
What is missing?

Performance numbers would be also nice to have.
Anton did great work on improving UML's drivers.

Thanks,
//richard
