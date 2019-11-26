Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lithops.sigma-star.at ([195.201.40.130]:42386 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfKZKJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 05:09:37 -0500
Date: Tue, 26 Nov 2019 11:09:34 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <243342257.98153.1574762974057.JavaMail.zimbra@nod.at>
In-Reply-To: <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
References: <cover.1573179553.git.thehajime@gmail.com> <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com> <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com> <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net> <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at> <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>, tavi purdila <tavi.purdila@gmail.com>, linux-um <linux-um@lists.infradead.org>, retrage01 <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, pscollins <pscollins@google.com>, sigmaepsilon92 <sigmaepsilon92@gmail.com>, liuyuan <liuyuan@google.com>

----- Ursprüngliche Mail -----
>> My point is that UML and LKL should try to do use the same concept/code
>> regarding virtio. At the end of day both use virtual devices which use
>> facilities from the host.
>> If this is really not possible it needs a good explanation.
> 
> I think it isn't possible, unless you use vhost-user over a unix domain
> socket internally to talk between the kernel (virtio_uml) and hypervisor
> (device) components.
> 
> In virtio_uml, the device implementation is assumed to be a separate
> process with a vhost-user connection. Here in LKL, the virtio device is
> part of the "hypervisor", i.e. in the same process.

Exactly, currently UML and LKL solve same things differently, but do we need to?

If we fail to agree on such a high level I might make sense to reevaluate to option
of not merging UML and LKL at all.
But this is beyond my decisional power and something I'd like to avoid.

Thanks,
//richard
