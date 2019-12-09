Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIP6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 10:58:35 -0500
MIME-Version: 1.0
References: <20191209135823.28465-1-hch@lst.de> <20191209135823.28465-3-hch@lst.de>
In-Reply-To: <20191209135823.28465-3-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Dec 2019 16:58:15 +0100
Message-ID: <CAK8P3a0xD-kdKYzDp+hvN=uHwSJtzYE-YSyR3_mkxOTUEs-C3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] remove ioremap_nocache and devm_ioremap_nocache
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20191209155815.pDkySNiqne65RN8Lrn8eeaC3J9_hGtMbffAkBNNmoE0@z>

On Mon, Dec 9, 2019 at 2:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> ioremap has provided non-cached semantics by default since the Linux 2.6
> days, so remove the additional ioremap_nocache interface.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Great work, thanks for getting this done!

Acked-by: Arnd Bergmann <arnd@arndb.de>
