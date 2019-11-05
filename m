From: Anatoly Pugachev <matorola@gmail.com>
Subject: Re: [PATCH v4 00/13] mm: remove __ARCH_HAS_4LEVEL_HACK
Date: Tue, 5 Nov 2019 17:58:20 +0300
Message-ID: <CADxRZqyJewYKn_juVPrxm9KVQjZQngnig-FYf1q3G6wc=oawYQ@mail.gmail.com>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572938135-31886-1-git-send-email-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 5, 2019 at 10:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.
>
> For the nommu configurations the folding is already implemented by the
> generic code so the only change was to use the appropriate header file.
>
> As for the rest, the changes are mostly about mechanical replacement of
> pgd accessors with pud/pmd ones and the addition of higher levels to page
> table traversals.
>
> With Vineet's patches from "elide extraneous generated code for folded
> p4d/pud/pmd" series [1] there is a small shrink of the kernel size of about
> -0.01% for the defconfig builds.
>
> The set is boot-tested on UML, qemu-{alpha,sparc} and aranym.
>
> v4 changes:
> * m68k: fix sun3x_defconfig build and reorder ifdefs as per Geert's
>   suggestion


Mike,

tested your patch series on a debian sid/unstable sparc64 LDOM running
on a T5-2 sparc server - it boots for me.
