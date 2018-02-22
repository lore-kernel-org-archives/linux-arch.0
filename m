Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34267 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeBVQeD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 11:34:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180222162845.GC9891@saruman>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222162845.GC9891@saruman>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:34:02 +0100
Message-ID: <CAK8P3a3-G6Euq42zCRxyFmUfU23OKNQRebo1ExHtHgN3w8S4ww@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 5:28 PM, James Hogan <jhogan@kernel.org> wrote:
> Hi Arnd,
>
> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>> * Meta was ImgTec's own architecture and they upstreamed the kernel
>>   port just before they acquired MIPS. Apparently Meta was abandoned
>>   shortly afterwards and disappeared from imgtec's website in 2014.
>>   The maintainer is still fixing bugs in the port, but I could not find
>>   any toolchain more recent than
>>   https://github.com/img-meta/metag-buildroot/tree/metag-core/toolchain/gcc/4.2.4
>>   Not sure about this one, I'd be interested in more background
>>   from James Hogan, who probably has an opinion and might have
>>   newer toolchain sources.
>
> Interesting timing! Have you seen this (which I'll send for 4.17, and
> leave 4.16 broken)?
>
> https://marc.info/?l=linux-kernel&m=151925667323732&w=2

No, I missed that. Could have saved me some of the research I did
when coming up with the list ;-)

> The Meta port is essentially unused and for a while I have only looked
> at it when something went wrong. PURE's Linux based digital radios I
> believe were never updated to 3.10. The fact that the GCC port wasn't
> upstreamed before the MIPS acquisition meant it was always a ticking
> time bomb (though binutils was upstreamed).
>
> Sad really, given that at least 9 years of effort went into the port
> before permission was finally given to upstream it, and within a week or
> so of the first patchset the intention to acquire MIPS was announced.

Indeed.

      Arnd
