Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38124 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeBVQTF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 11:19:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180222160217.GA18243@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:19:04 +0100
Message-ID: <CAK8P3a1ZMQTPq1Szvgdg3yzpr+LdsoDaO6YtzNUycYcbOzDPSQ@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 5:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>> There are also a couple of architectures that are more or less
>> unmaintained but do have working gcc support: FR-V and M32R
>> have been orphaned for a while and are not getting updated
>> MN10300 is still maintained officially by David Howells but doesn't
>> seem any more active than the other two, the last real updates were
>> in 2013.
>
> I'd love to see dead architecture ports dropped if they really are
> more or less abandoned.  In addition to your missing gcc port ones
> above (minus openrisc) it seems like frv and m32r certainly qualify,
> and xtensa seems to be going that way with the glibc port being dropped
> now.

Regarding xtensa, I looked at that one while I wrote my list and it seems
quite a bit more active than the others. Cris and xtensa are two architectures
that don't see much maintenance over long periods of time but occasionally
get a proper update. For xtensa this just happened, see [1]. Unlike cris,
xtensa is also commercially still very successful, just less so in the
Linux+glibc space.

       Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0bd31dc5c0b46b9c778112900cf8f910ac26e1b
