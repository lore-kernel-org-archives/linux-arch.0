Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46018 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBWMUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 07:20:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve5b+pV78xU0DHi9644GT11gwe6sqzqrj_4xRjHHM5yRg@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net> <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <CAHp75Ve5b+pV78xU0DHi9644GT11gwe6sqzqrj_4xRjHHM5yRg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 13:20:05 +0100
Message-ID: <CAK8P3a1az+TbmgT-3-sXAdp04XPP=ocxfhcZK1htMMcMnKa=xg@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Fri, Feb 23, 2018 at 1:09 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 12:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> ia64 as far as I *heard* from some news will be in support (I mean by
> vendors) for few more years. Not a fun, just business.

My impression was that the business side is only on enterprise distros
(SLES11 is still supported, RHEL5 is on 'extended support' only), but not
with mainline kernels. Anyway, it doesn't matter as nobody is suggestion
to remove it any time soon.

        Arnd
