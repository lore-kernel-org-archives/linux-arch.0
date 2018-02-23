Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:45490 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBWVfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 16:35:52 -0500
Date: Fri, 23 Feb 2018 22:34:23 +0100
From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180223213423.iskp7kmvy6rd52gc@angband.pl>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
 <1519414328.30443.29.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519414328.30443.29.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, Feb 23, 2018 at 02:32:08PM -0500, James Bottomley wrote:
> On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
> [...]
> > IIRC, parisc/qemu stuff had been announced a while ago;
> 
> I have, but it didn't work sufficiently for me to either boot a kernel
> using system emulation or start an architecture container using user
> emulation.  I'll try again now that qemu has gone through several
> revisions.

Doesn't seem to work.  Debian package (1:2.11+dfsg-1) ships hppa support but
it doesn't even install binfmt; otherwise, -user is functional enough for a
minimal executable (so arch-test reports it as working[1]), but not for
anything libc:

[/srv/chroots/hppa]# chroot . /usr/bin/qemu-hppa-static /bin/true
qemu-hppa-static: /build/qemu-v8TF72/qemu-2.11+dfsg/target/hppa/translate.c:422: nullify_end: Assertion `status != DISAS_NORETURN && status != DISAS_IAQ_N_UPDATED' failed.
Segmentation fault

This looks bad enough that I didn't even look at qemu-system.


ᛗᛖᛟᚹ!

[1]. On archs without changed baseline, the test is just
write(1,"ok\n",3);_exit(0); unless there's a known issue to look for
such as swpb emulation being nop, etc.
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀ 
