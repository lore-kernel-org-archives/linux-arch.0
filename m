Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2019 06:25:48 -0400
Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: remove __ARCH_HAS_4LEVEL_HACK
Content-Type: text/plain; charset="UTF-8"
To: Mike Rapoport <rppt@kernel.org>
Cc: Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023102548.fUy-aCQ2wtHuerfNnooy4eb1S4rXIsDrFC_bPxyOejU@z>

On Wed, Oct 23, 2019 at 5:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.

Thanks for doing this.

The patches look sane from a quick scan, and it's definitely the right
thing to do. So ack on my part, but obviously testing the different
architectures would be a really good thing...

                Linus
