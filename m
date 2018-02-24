Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39319 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeBXEEw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 23:04:52 -0500
Subject: Re: Removing architectures without upstream gcc support
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop> <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
 <1519414328.30443.29.camel@HansenPartnership.com>
 <20180223213423.iskp7kmvy6rd52gc@angband.pl>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4d9a9c9-f05d-4981-b03b-02ced665254e@roeck-us.net>
Date: Fri, 23 Feb 2018 20:04:48 -0800
MIME-Version: 1.0
In-Reply-To: <20180223213423.iskp7kmvy6rd52gc@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On 02/23/2018 01:34 PM, Adam Borowski wrote:
> On Fri, Feb 23, 2018 at 02:32:08PM -0500, James Bottomley wrote:
>> On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
>> [...]
>>> IIRC, parisc/qemu stuff had been announced a while ago;
>>
>> I have, but it didn't work sufficiently for me to either boot a kernel
>> using system emulation or start an architecture container using user
>> emulation.  I'll try again now that qemu has gone through several
>> revisions.
> 
> Doesn't seem to work.  Debian package (1:2.11+dfsg-1) ships hppa support but
> it doesn't even install binfmt; otherwise, -user is functional enough for a
> minimal executable (so arch-test reports it as working[1]), but not for
> anything libc:
> 
> [/srv/chroots/hppa]# chroot . /usr/bin/qemu-hppa-static /bin/true
> qemu-hppa-static: /build/qemu-v8TF72/qemu-2.11+dfsg/target/hppa/translate.c:422: nullify_end: Assertion `status != DISAS_NORETURN && status != DISAS_IAQ_N_UPDATED' failed.
> Segmentation fault
> 
> This looks bad enough that I didn't even look at qemu-system.
> 

qemu-system-hppa support was added to qemu end of January. It seems to boot fine,
only I lost my ability to build a root file system :-( so it may take a bit
for me to create one.

Guenter
