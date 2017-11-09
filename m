From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 00/31] Andes(nds32) Linux Kernel Port
Date: Thu, 9 Nov 2017 17:26:31 +0800
Message-ID: <CAEbi=3eKCbEywwLdpou4=WKqYYc9gRvjaD5d0oLgF2dqgp9Kyw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7795.1510129943@warthog.procyon.org.uk>
 <CAEbi=3djUeMtRniq0Z98tVZw_QXB7hfS_mubrot3zHyTjvWZ9A@mail.gmail.com> <CAK8P3a3j9PnATcLG3hbw_sLM54LKvB021QM+wJQAQYLOsaZSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:54149 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbdKIJ1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 04:27:13 -0500
In-Reply-To: <CAK8P3a3j9PnATcLG3hbw_sLM54LKvB021QM+wJQAQYLOsaZSqw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, deanbo422@gmail.com

2017-11-08 18:18 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 9:41 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-08 16:32 GMT+08:00 David Howells <dhowells@redhat.com>:
>>> Greentime Hu <green.hu@gmail.com> wrote:
>>>
>>>> The build script and toolchain repositories are able to be found here:
>>>>   https://github.com/andestech/build_script.git
>>>
>>> Is arch support in upstream binutils and gcc?
>>
>> Yes, it is but only supporting elf-toolchain now. We will do the
>> upstream for Linux-toolchain in the next step.
>
> Is the Linux toolchain only required for building user space, or do
> you also need it
> for building kernels? It's often possible to build kernels with a bare
> toolchain, and
> that helps a lot for automated testing.

Yes, nds32 kernel is able to be built with elf-toolchain too.
