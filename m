Return-Path: <SRS0=06hN=5A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35863 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgCODgm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Mar 2020 23:36:42 -0400
Date: Sat, 14 Mar 2020 12:02:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND PATCH v2 1/9] iomap: Constify ioreadX() iomem argument
 (as in generic implementation)
Message-ID: <20200314110258.GA16135@kozik-lap>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219175007.13627-2-krzk@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org
Message-ID: <20200314110258.FRV5iytIcNlBx6_MwMh8zAPIOeQ3HJdv0JkPnENHYyM@z>

On Wed, Feb 19, 2020 at 06:49:59PM +0100, Krzysztof Kozlowski wrote:
> The ioreadX() and ioreadX_rep() helpers have inconsistent interface.  On
> some architectures void *__iomem address argument is a pointer to const,
> on some not.
> 
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

This patch touches multipel file systems so no one is brave enough to
pick it up. However you are mentioned as maintainer of generic asm
headers so maybe you could apply it to arm-soc?

Best regards,
Krzysztof


> 
> ---
> 
> Changes since v1:
> 1. Constify also ioreadX_rep() and mmio_insX(),
> 2. Squash lib+alpha+powerpc+parisc+sh into one patch for bisectability,
> 3. Add Geert's review.
> 4. Add Arnd's review.
> ---
>  arch/alpha/include/asm/core_apecs.h   |  6 +--
>  arch/alpha/include/asm/core_cia.h     |  6 +--
>  arch/alpha/include/asm/core_lca.h     |  6 +--
>  arch/alpha/include/asm/core_marvel.h  |  4 +-
>  arch/alpha/include/asm/core_mcpcia.h  |  6 +--
>  arch/alpha/include/asm/core_t2.h      |  2 +-
>  arch/alpha/include/asm/io.h           | 12 ++---
>  arch/alpha/include/asm/io_trivial.h   | 16 +++---
>  arch/alpha/include/asm/jensen.h       |  2 +-
>  arch/alpha/include/asm/machvec.h      |  6 +--
>  arch/alpha/kernel/core_marvel.c       |  2 +-
>  arch/alpha/kernel/io.c                | 12 ++---
>  arch/parisc/include/asm/io.h          |  4 +-
>  arch/parisc/lib/iomap.c               | 72 +++++++++++++--------------
>  arch/powerpc/kernel/iomap.c           | 28 +++++------
>  arch/sh/kernel/iomap.c                | 22 ++++----
>  include/asm-generic/iomap.h           | 28 +++++------
>  include/linux/io-64-nonatomic-hi-lo.h |  4 +-
>  include/linux/io-64-nonatomic-lo-hi.h |  4 +-
>  lib/iomap.c                           | 30 +++++------
>  20 files changed, 136 insertions(+), 136 deletions(-)
> 
