Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <1572850587-20314-1-git-send-email-rppt@kernel.org> <1572850587-20314-14-git-send-email-rppt@kernel.org>
In-Reply-To: <1572850587-20314-14-git-send-email-rppt@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Nov 2019 10:11:51 +0100
Message-ID: <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and include/asm-generic/4level-fixup.h
Content-Type: text/plain; charset="UTF-8"
To: Mike Rapoport <rppt@kernel.org>
Cc: Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-um@lists.infradead.org, sparclinux <sparclinux@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191104091151.b2RsX_VHzJIw6dJAJKRzmWp912hyuUEvf5QuEpncCkM@z>

On Mon, Nov 4, 2019 at 7:58 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> There are no architectures that use include/asm-generic/4level-fixup.h
> therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Have you discussed how the series should get merged? I assume an initial
set of patches can just go through architecture maintainer trees, but
whatever patches don't get picked up that way would go through either
Andrew's -mm tree (for memory management) or my asm-generic tree
(for cross-architecture cleanups).

Since there is still at least one regression, I expect not to do anything
for now. Please let me know when/if you expect me to merge the
remaining patches.

      Arnd
