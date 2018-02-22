Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbeBVQCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 11:02:21 -0500
Date: Thu, 22 Feb 2018 08:02:17 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180222160217.GA18243@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
> There are also a couple of architectures that are more or less
> unmaintained but do have working gcc support: FR-V and M32R
> have been orphaned for a while and are not getting updated
> MN10300 is still maintained officially by David Howells but doesn't
> seem any more active than the other two, the last real updates were
> in 2013.

I'd love to see dead architecture ports dropped if they really are
more or less abandoned.  In addition to your missing gcc port ones
above (minus openrisc) it seems like frv and m32r certainly qualify,
and xtensa seems to be going that way with the glibc port being dropped
now.
