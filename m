Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55616 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeBWPom (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Feb 2018 10:44:42 -0500
Date: Fri, 23 Feb 2018 15:43:16 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180223154316.35b26857@alans-desktop>
In-Reply-To: <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
        <20180222234833.GA3047@roeck-us.net>
        <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

> Regarding the older architectures I mentioned (m32r, frv, mn10300),
> the situation is a bit different as they don't have the problems with
> build testing but they do have problems with using less of the
> standard interfaces (syscall, timer, gpio, rtc, ...), so they do add
> more to the maintenance burden without the nostalgia value of
> some of the even older architectures (parisc, alpha, m68k, ia64)
> that people maintain mainly for fun.

IMHO the magic word is 'maintain'. If someone is actively maintaining it
then I don't think we should care too much, if not then while the code
may be buildable on current systems does anyone honestly think it works
properly if used in anger ?

Alan
