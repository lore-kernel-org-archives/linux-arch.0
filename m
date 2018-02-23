Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38412 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWRKX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 12:10:23 -0500
Date: Fri, 23 Feb 2018 09:10:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180223171019.GA1125@roeck-us.net>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223154316.35b26857@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, Feb 23, 2018 at 03:43:16PM +0000, Alan Cox wrote:
> > Regarding the older architectures I mentioned (m32r, frv, mn10300),
> > the situation is a bit different as they don't have the problems with
> > build testing but they do have problems with using less of the
> > standard interfaces (syscall, timer, gpio, rtc, ...), so they do add
> > more to the maintenance burden without the nostalgia value of
> > some of the even older architectures (parisc, alpha, m68k, ia64)
> > that people maintain mainly for fun.
> 
> IMHO the magic word is 'maintain'. If someone is actively maintaining it
> then I don't think we should care too much, if not then while the code
> may be buildable on current systems does anyone honestly think it works
> properly if used in anger ?
> 

FWIW, alpha and m68k are known boot with qemu (even though m68k
generates a warning traceback with the mainline kernel).

Guenter
