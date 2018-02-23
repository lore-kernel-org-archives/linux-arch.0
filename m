Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34294 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWSTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 13:19:50 -0500
Date: Fri, 23 Feb 2018 18:19:44 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180223181943.GF30522@ZenIV.linux.org.uk>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223171019.GA1125@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, Feb 23, 2018 at 09:10:19AM -0800, Guenter Roeck wrote:

> FWIW, alpha and m68k are known boot with qemu (even though m68k
> generates a warning traceback with the mainline kernel).

alpha works with qemu (I considered putting together a debian
autobuilder on that, got mired in the scripts; builds AFAICS
happen the same way as on the actual hardware, and considerably
faster than any of the alpha boxen I've got here).  For m68k,
IIRC, qemu is mostly for coldfire and friends with aranym
working for m68k/MMU testing.

IIRC, parisc/qemu stuff had been announced a while ago; I hadn't
tried that yet (got an old parisc box, so 32bit testing can be
done on that).  Itanic... ski(1) is, IME, not usable for kernel
testing and AFAIK no usable ia64/qemu exists.  That's another
one that has to be tested on actual hardware.
