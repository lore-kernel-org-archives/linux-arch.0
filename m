Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:10386
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752195AbeBWX7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Feb 2018 18:59:11 -0500
Subject: Re: Removing architectures without upstream gcc support
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop> <20180223171019.GA1125@roeck-us.net>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <7da72881-2c19-9e6d-0a70-7767cab19437@linux-m68k.org>
Date: Sat, 24 Feb 2018 09:49:40 +1000
MIME-Version: 1.0
In-Reply-To: <20180223171019.GA1125@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On 24/02/18 03:10, Guenter Roeck wrote:
> On Fri, Feb 23, 2018 at 03:43:16PM +0000, Alan Cox wrote:
>>> Regarding the older architectures I mentioned (m32r, frv, mn10300),
>>> the situation is a bit different as they don't have the problems with
>>> build testing but they do have problems with using less of the
>>> standard interfaces (syscall, timer, gpio, rtc, ...), so they do add
>>> more to the maintenance burden without the nostalgia value of
>>> some of the even older architectures (parisc, alpha, m68k, ia64)
>>> that people maintain mainly for fun.
>>
>> IMHO the magic word is 'maintain'. If someone is actively maintaining it
>> then I don't think we should care too much, if not then while the code
>> may be buildable on current systems does anyone honestly think it works
>> properly if used in anger ?
>>
> 
> FWIW, alpha and m68k are known boot with qemu (even though m68k
> generates a warning traceback with the mainline kernel).

At the very least I build every defconfig for every rc and release
kernel for m68k. I also run a ColdFire build through qemu (non-MMU)
and also run it and an MMU build on real hardware. So they are
always checked and by far mostly work - and when they don't I fix
it ASAP.

I am pretty sure Geert does similar for the traditional 68k targets.
NXP still sell ColdFire parts, so for the moment it is not dead
in terms of available silicon.

(*) I know linux-4.16-rc1 and rc2 issue a warning on boot of a
non-MMU m68k/coldfire build due to the addition of a warning by
Christoph in 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask") but I haven't had a chance to track what the
exact problem is there.

Regards
Greg
