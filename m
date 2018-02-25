Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:36108 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbeBYU31 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 25 Feb 2018 15:29:27 -0500
Date: Sun, 25 Feb 2018 20:28:06 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180225202806.735a6870@alans-desktop>
In-Reply-To: <20180223171019.GA1125@roeck-us.net>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
        <20180222234833.GA3047@roeck-us.net>
        <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
        <20180223154316.35b26857@alans-desktop>
        <20180223171019.GA1125@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

> FWIW, alpha and m68k are known boot with qemu (even though m68k
> generates a warning traceback with the mainline kernel).

M68K works - people actively use it. Crazy people true 8). Alpha I
believe one or two people boot. I just need to track down some discs for
my Alpha 8)

Alan
