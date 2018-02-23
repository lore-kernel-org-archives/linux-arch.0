Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45741 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWOdB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 09:33:01 -0500
Subject: Re: Removing architectures without upstream gcc support
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c86ec381-963c-7460-9e02-4ebeeac1c8fb@roeck-us.net>
Date: Fri, 23 Feb 2018 06:32:57 -0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On 02/23/2018 02:32 AM, Arnd Bergmann wrote:
> On Fri, Feb 23, 2018 at 12:48 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>>> While building the cross-toolchains, I noticed that overall, we can build almost
>>> all linux target architectures with upstream binutils and gcc these days,
>>> however there are still some exceptions, and I'd like to find out if anyone
>>> has objections to removing the ones that do not have upstream support.
>>> This are the four architectures I found:
>>>
>>> * score (s+core, sunplus core) was a proprietary RISC architecture
>>>    made by sunplus. It is unclear if they still ship any products based on
>>>    this architecture, all they list is either ARM Cortex-A9 or an unspecified
>>>    RISC core that could be any of arm, mips, nds32, arc, xtensa or
>>>    something completely different. The two maintainers have both left the
>>>    company many years ago and have not contributed any patches in
>>>    at least five years. There was an upstream gcc port, which was marked
>>>    'obsolete' in 2013 and got removed in gcc-5.0.
>>>    I conclude that this is dead in Linux and can be removed
>>>
>>> * unicore32 was a research project at Peking University with a SoC
>>>    based on the Intel PXA design. No gcc source code has ever been
>>>    published, the only toolchain available is a set of binaries that include
>>>    a gcc-4.4 compiler. The project page at
>>>    http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>>>    not been modified since 2011. The maintainer still Acks patches
>>>    and has last sent a pull request in 2014 and last sent a patch of
>>>    his own in 2012 when the project appears to have stalled.
>>>    I would suggest removing this one.
>>>
>>
>> The above two would be primary removal targets for me; they are all
>> but impossible to support given the toolchain limitations. Meta
>> would have been another one, but James is already taking care of it.
> 
> Ok. Have you had any success building arch/hexagon with clang?
> 

I have not tried. It is a pain having to use different toolchains for different
kernel versions, and I only do it if I absolutely have to. I use "hexagon-linux-gcc
(Sourcery CodeBench Lite 2012.03-66) 4.6.1".

Guenter
