From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] io.h, logic_pio: Allow barriers for inX() and outX()
 be overridden
Date: Wed, 18 Mar 2020 17:21:04 +0100
Message-ID: <CAK8P3a0uxCyOZS0jkWM9DcAeQaKBEjovMC0QudLbu-1WK2i3Yw@mail.gmail.com>
References: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:45257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 12:21:23 -0400
In-Reply-To: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: "xuwei (O)" <xuwei5@huawei.com>, Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>, Olof Johansson <olof@lixom.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>

On Wed, Mar 18, 2020 at 4:59 PM John Garry <john.garry@huawei.com> wrote:
>
> Since commits a7851aa54c0c ("io: change outX() to have their own IO
> barrier overrides") and 87fe2d543f81 ("io: change inX() to have their own
> IO barrier overrides"), the outX() and inX() functions have memory
> barriers which can be overridden per-arch.
>
> However, under CONFIG_INDIRECT_PIO, logic_pio defines its own version of
> inX() and outX(), which still use readb et al. For these, the barrier
> after a raw read is weaker than it otherwise would be.
>
> This series generates consistent behaviour for logic_pio, by defining
> generic _inX() and _outX() in asm-generic/io.h, and using those in
> logic_pio. Generic _inX() and _outX() have per-arch overrideable
> barriers.
>
> The topic was discussed there originally:
> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>
> A small tidy-up patch is included.
>
> I hope that series can go through the arm-soc tree, as with other recent
> logic_pio changes.

Looks good to me, thanks for the cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
