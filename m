Return-Path: <SRS0=+omB=25=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgAHIo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jan 2020 03:44:58 -0500
MIME-Version: 1.0
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com> <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
In-Reply-To: <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Jan 2020 09:44:36 +0100
Message-ID: <CAK8P3a21yPrmp4ik3Ei1BZfeqZNf0wL5NZNF3uXqb4FLRDyUPw@mail.gmail.com>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, ML nouveau <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, Parisc List <linux-parisc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20200108084436.3kU4QUpQJa1vBmAWAgTJOgQX1zRJ-WMDtncr4O_JmiE@z>

On Wed, Jan 8, 2020 at 9:36 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> Le 08/01/2020 à 09:18, Krzysztof Kozlowski a écrit :
> > On Wed, 8 Jan 2020 at 09:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I'll add to this one also changes to ioreadX_rep() and add another
> > patch for volatile for reads and writes. I guess your review will be
> > appreciated once more because of ioreadX_rep()
> >
>
> volatile should really only be used where deemed necessary:
>
> https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.html
>
> It is said: " ...  accessor functions might use volatile on
> architectures where direct I/O memory access does work. Essentially,
> each accessor call becomes a little critical section on its own and
> ensures that the access happens as expected by the programmer."

The I/O accessors are one of the few places in which 'volatile' generally
makes sense, at least for the implementations that do a plain pointer
dereference (probably none of the ones in question here).

In case of readl/writel, this is what we do in asm-generic:

static inline u32 __raw_readl(const volatile void __iomem *addr)
{
        return *(const volatile u32 __force *)addr;
}

The __force-cast that removes the __iomem here also means that
the 'volatile' keyword could be dropped from the argument list,
as it has no real effect any more, but then there are a few drivers
that mark their iomem pointers as either 'volatile void __iomem*' or
(worse) 'volatile void *', so we keep it in the argument list to not
add warnings for those drivers.

It may be time to change these drivers to not use volatile for __iomem
pointers, but that seems out of scope for what Krzysztof is trying
to do. Ideally we would be consistent here though, either using volatile
all the time or never.

        Arnd
