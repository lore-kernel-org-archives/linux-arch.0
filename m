From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] remove ioremap_nocache and devm_ioremap_nocache
Date: Mon, 9 Dec 2019 16:58:15 +0100
Message-ID: <CAK8P3a0xD-kdKYzDp+hvN=uHwSJtzYE-YSyR3_mkxOTUEs-C3w@mail.gmail.com>
References: <20191209135823.28465-1-hch@lst.de> <20191209135823.28465-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209135823.28465-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 9, 2019 at 2:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> ioremap has provided non-cached semantics by default since the Linux 2.6
> days, so remove the additional ioremap_nocache interface.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Great work, thanks for getting this done!

Acked-by: Arnd Bergmann <arnd@arndb.de>
