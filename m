Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38937 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeBZI07 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Feb 2018 03:26:59 -0500
MIME-Version: 1.0
In-Reply-To: <2d12dc77-16b9-417d-72e3-2b1ffa38803d@gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <2d12dc77-16b9-417d-72e3-2b1ffa38803d@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 09:26:57 +0100
Message-ID: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180226082657.BxT44U4GOBM7jkloEyhl0i56I9aDJWroZ5pD2aafh8k@z>

On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
>
> Add blackfin to that list, there have been no responses from the
> maintainers last time I posted patches to remove DSA header files, so we
> had to go these through the networking tree. Have not see a Blackfin
> pull request since forever, Aaron himself seems to agree this should be
> removed:
>
> http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html

Peter Zijlstra also mentioned that one on IRC, I didn't have it on my radar
before. Like Tile, it has only recently been marked as Orphaned in MAINTAINERS,
so I'd be inclined to wait a little while to give possible users a
chance to step
up as new maintainers.

My plan for v4.17 is now:

- remove score, unicore and metag due to lack of toolchain
  or interest from the maintainers.
- keep hexagon, and try to build an llvm/clang toolchain
- remove frv and m32r due to being abandoned for several years
- mark tile and blackfin for pending removal later this year unless
  a new maintainer steps up
- mark mn10300 for pending removal unless it gets updated to
  support chips that were made in the past 12 years and to build
  properly.

       Arnd
