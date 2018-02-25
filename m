Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:17636 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeBYQCK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Feb 2018 11:02:10 -0500
Subject: Re: [OpenRISC] Removing architectures without upstream gcc support
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
From: Philipp Wagner <lists@philipp-wagner.com>
Message-ID: <155284c9-7fd4-2f2c-0216-1c43622f88c3@philipp-wagner.com>
Date: Sun, 25 Feb 2018 16:43:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, David Howells <dhowells@redhat.com>, openrisc@lists.librecores.org, Lennox Wu <lennox.wu@gmail.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-metag@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>

Am 22.02.2018 um 16:45 schrieb Arnd Bergmann:
> While building the cross-toolchains, I noticed that overall, we can build almost
> all linux target architectures with upstream binutils and gcc these days,
> however there are still some exceptions, and I'd like to find out if anyone
> has objections to removing the ones that do not have upstream support.
> This are the four architectures I found:
> [...]
> * OpenRISC is a RISC architecture with a free license and an
>   active community. It seems to have lost a bit of steam after RISC-V
>   is rapidly taking over that niche, but there are chips out there and
>   the design isn't going away. Listing it here for completeness only
>   because there is no upstream gcc port yet, but this will hopefully
>   change in the future based on
>   https://lists.librecores.org/pipermail/openrisc/2018-January/000958.html
>   and I had no problems locating the gcc-7.x tree for building my
>   toolchains. The port is actively being maintained.

It's mostly mentioned in the mailing list thread you linked to, but just
for completeness in this thread:

The OpenRISC GCC port is maintained and regularly updated to newer GCC
versions. It is not, however, upstreamed to the FSF due to a single
missing FSF copyright assignment from a developer who has written large
parts of the initial port. All code which has copyright assignments in
place (binutils, GDB, etc.) has been upstreamed lately.

For GCC, Stafford Horne is actively working on rewriting the parts which
we don't have the FSF copyright assignment for (and unless something
very surprising happens, won't get). [If anyone wants to help, there's
GSoC project for it as well:
https://fossi-foundation.org/gsoc18-ideas#openrisc-gcc-port]

So I'd be very sad if the openrisc port gets dropped from Linux upstream.

Philipp
