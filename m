From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 32/35] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
Date: Mon, 27 Nov 2017 15:14:06 +0100
Message-ID: <CAK8P3a0RxcaXx5kdikCap37dy=5eGt_sjHxk3hw2ps0hEdhCOA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <44e31de43dab9abecdc08f9a87244205f054cfa6.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33134 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdK0OOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:14:08 -0500
In-Reply-To: <44e31de43dab9abecdc08f9a87244205f054cfa6.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> It allows some architectures to use this generic macro instead of
> defining theirs.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  include/asm-generic/io.h |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

This looks good, but you probably want to do this earlier in the series, so you
can build on top of this change.

Please keep this patch as part of your series,

Acked-by: Arnd Bergmann <arnd@arndb.de>
