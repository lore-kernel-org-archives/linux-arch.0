Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37513 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWKcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 05:32:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180222234833.GA3047@roeck-us.net>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 11:32:32 +0100
Message-ID: <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, Feb 23, 2018 at 12:48 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>> While building the cross-toolchains, I noticed that overall, we can build almost
>> all linux target architectures with upstream binutils and gcc these days,
>> however there are still some exceptions, and I'd like to find out if anyone
>> has objections to removing the ones that do not have upstream support.
>> This are the four architectures I found:
>>
>> * score (s+core, sunplus core) was a proprietary RISC architecture
>>   made by sunplus. It is unclear if they still ship any products based on
>>   this architecture, all they list is either ARM Cortex-A9 or an unspecified
>>   RISC core that could be any of arm, mips, nds32, arc, xtensa or
>>   something completely different. The two maintainers have both left the
>>   company many years ago and have not contributed any patches in
>>   at least five years. There was an upstream gcc port, which was marked
>>   'obsolete' in 2013 and got removed in gcc-5.0.
>>   I conclude that this is dead in Linux and can be removed
>>
>> * unicore32 was a research project at Peking University with a SoC
>>   based on the Intel PXA design. No gcc source code has ever been
>>   published, the only toolchain available is a set of binaries that include
>>   a gcc-4.4 compiler. The project page at
>>   http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>>   not been modified since 2011. The maintainer still Acks patches
>>   and has last sent a pull request in 2014 and last sent a patch of
>>   his own in 2012 when the project appears to have stalled.
>>   I would suggest removing this one.
>>
>
> The above two would be primary removal targets for me; they are all
> but impossible to support given the toolchain limitations. Meta
> would have been another one, but James is already taking care of it.

Ok. Have you had any success building arch/hexagon with clang?

Regarding the older architectures I mentioned (m32r, frv, mn10300),
the situation is a bit different as they don't have the problems with
build testing but they do have problems with using less of the
standard interfaces (syscall, timer, gpio, rtc, ...), so they do add
more to the maintenance burden without the nostalgia value of
some of the even older architectures (parisc, alpha, m68k, ia64)
that people maintain mainly for fun.

     Arnd
