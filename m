Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36938 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCFKir (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2018 05:38:47 -0500
MIME-Version: 1.0
In-Reply-To: <649EF91064D35D40B9C93A225BF41674ADE25B7B@NWD2MBX6.ad.analog.com>
References: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
 <5ef16c51-7cc5-9111-7e54-edfe77f39f4b@metafoo.de> <649EF91064D35D40B9C93A225BF41674ADE252E2@NWD2MBX6.ad.analog.com>
 <CAK8P3a2Jg93i-DCU0jVMUqX6b9tEx3odsEGj8dTBNjSoN-8ZRQ@mail.gmail.com> <649EF91064D35D40B9C93A225BF41674ADE25B7B@NWD2MBX6.ad.analog.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 11:38:45 +0100
Message-ID: <CAK8P3a22wAv2kjkhdBpAkdhzMD9m6y_bmLjOba+1sVe7m713ww@mail.gmail.com>
Subject: Re: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wu, Aaron" <Aaron.Wu@analog.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux- <kernel@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "liqin.linux@gmail.com" <liqin.linux@gmail.com>, "lennox.wu@gmail.com" <lennox.wu@gmail.com>, "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>, "linux@roeck-us.net" <linux@roeck-us.net>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jhogan@kernel.org" <jhogan@kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "jonas@southpole.se" <jonas@southpole.se>, "stefan.kristiansson@saunalahti.fi" <stefan.kristiansson@saunalahti.fi>, "shorne@gmail.com" <shorne@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>

On Tue, Mar 6, 2018 at 11:35 AM, Wu, Aaron <Aaron.Wu@analog.com> wrote:
>> >>
>> >> On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com>
>> wrote:
>> >> > On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
>> >> >
>> >> > Add blackfin to that list, there have been no responses from the
>> >> > maintainers last time I posted patches to remove DSA header files,
>> >> > so we had to go these through the networking tree. Have not see a
>> >> > Blackfin pull request since forever, Aaron himself seems to agree
>> >> > this should be
>> >> > removed:
>> >> >
>> >> > http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html
>> >>
>> >
>> > I'm sorry to confirm that ADI can no longer provide maintenance for
>> > Blackfin in Kernel community. We will try to provide a patch to remove it.
>> > Apologize... and sincerely thanks to community and all used and
>> > contributed to Blackfin Linux. Looking forward we are working on
>> > supporting Linux from the newer SC5xx mutli-core processors with ARM and
>> SHARC DSPs in it.
>>
>> Thanks a lot for your reply. I already compiled a list for files related to all of the
>> architectures under discussion, but it will certainly help to have a patch from you
>> as well, then I can see if one of use missed any files.
>>
>> I'm looking forward to your patches for the SHARC ARM platform, I was already
>> wondering about why we don't already have that platform in Linux.
>> Let me know if you need any help getting that port ready for inclusion.
>
> Thanks again, Arnd and the Community.
>>
>> One more question: I see that there are a number of drivers that are only used
>> on blackfin today. Do you know if any of those are shared with SHARC and still
>> needed, or can we remove everything related to blackfin?
>
> Some of them can be shared with the ARM-SHARCs processors, as of now
> we may go ahead to remove everything, when merging SHARC we can revert
> them back, probably with new file names without "bfin", if this sounds right.

Yes, sounds good. That also gives us a chance to review the drivers again
and update them to modern interfaces where necessary. At the minimum,
we will replace the traditional platform_data based probing with DT properties.

        Arnd
