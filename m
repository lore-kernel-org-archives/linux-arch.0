Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58638 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753702AbeBWTcM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Feb 2018 14:32:12 -0500
Message-ID: <1519414328.30443.29.camel@HansenPartnership.com>
Subject: Re: Removing architectures without upstream gcc support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 23 Feb 2018 14:32:08 -0500
In-Reply-To: <20180223181943.GF30522@ZenIV.linux.org.uk>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
         <20180222234833.GA3047@roeck-us.net>
         <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
         <20180223154316.35b26857@alans-desktop>
         <20180223171019.GA1125@roeck-us.net>
         <20180223181943.GF30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
[...]
> IIRC, parisc/qemu stuff had been announced a while ago;

I have, but it didn't work sufficiently for me to either boot a kernel
using system emulation or start an architecture container using user
emulation.  I'll try again now that qemu has gone through several
revisions.

>  I hadn't tried that yet (got an old parisc box, so 32bit testing can
> be done on that).

The mailing list (linux-parisc@vger.kernel.org) does regular build
testing on a variety of 32 and 64 bit hardware.

James
