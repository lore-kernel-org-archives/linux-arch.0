Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:46955 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeBVROM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 12:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180222160217.GA18243@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Feb 2018 09:14:11 -0800
Message-ID: <CAMo8BfLoqat+6CyOM2VV5Wz13NFMj54YisCogiVm95oDwdnTFQ@mail.gmail.com>
Subject: Re: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 8:02 AM, Christoph Hellwig <hch@infradead.org> wrote:
> I'd love to see dead architecture ports dropped if they really are
> more or less abandoned.  In addition to your missing gcc port ones
> above (minus openrisc) it seems like frv and m32r certainly qualify,
> and xtensa seems to be going that way with the glibc port being dropped
> now.

It's not that it's been dropped, there have never been an official glibc
port for xtensa, but we're working to get one.

-- 
Thanks.
-- Max
