Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38853 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBWLhq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 06:37:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180222180420.GA17956@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org> <CAMo8BfLoqat+6CyOM2VV5Wz13NFMj54YisCogiVm95oDwdnTFQ@mail.gmail.com>
 <20180222180420.GA17956@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 12:37:45 +0100
Message-ID: <CAK8P3a2VMbAARCFuBjY7TMuAfGM_h4BU3PfQA2C_pUFT34UHAA@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>, metcalf@alum.mit.edu

On Thu, Feb 22, 2018 at 7:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Feb 22, 2018 at 09:14:11AM -0800, Max Filippov wrote:
>> On Thu, Feb 22, 2018 at 8:02 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> > I'd love to see dead architecture ports dropped if they really are
>> > more or less abandoned.  In addition to your missing gcc port ones
>> > above (minus openrisc) it seems like frv and m32r certainly qualify,
>> > and xtensa seems to be going that way with the glibc port being dropped
>> > now.
>>
>> It's not that it's been dropped, there have never been an official glibc
>> port for xtensa, but we're working to get one.
>
> Ah sorry - I meant to say tile not xtensa when writing this.

That makes more sense, yes. I'm still unsure about this one though. Chris in
fact made the suggestion to remove the architecture from both glibc and kernel
as with his departure from Mellanox there is nobody left from to maintain it.

I suggested keeping it as 'Orphaned' for the time being, given that the port
is still in a good shape, much better than many other ports.

The known customers that sold TileGX based appliances (Cisco, Brocade,
Checkpoint, Mikrotik, ...) tend to have long support cycles, and there have
been attempts at getting Debian, OpenWRT and Centos distro support
at least a few years ago.

According to one comment, at least Cisco doesn't use the mainline kernels [1],
and it's likely similar for the others.

The other architecture that was recently marked 'obsolete' is Blackfin,
if we remove Tile, then that one can probably get removed as well.

          Arnd

[1] http://sourceware-org.1504.n7.nabble.com/RFC-remove-the-quot-tile-quot-architecture-from-glibc-td486836i20.html#a491434
