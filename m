From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Sat, 03 Dec 2016 11:43:07 +0100
Message-ID: <55460922.iQ4WX6OtHo@wuerfel>
References: <20161129131922.GA31466@angband.pl> <8452191.39CeLIHTBT@wuerfel> <1480739797.16599.118.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1480739797.16599.118.camel@decadent.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Saturday, December 3, 2016 4:36:37 AM CET Ben Hutchings wrote:
> On Fri, 2016-12-02 at 13:40 +0100, Arnd Bergmann wrote:
> > With binutils-2.16 and before, a weak missing symbol was kept during the
> > final link, and a missing CRC for an export would lead to that CRC
> > being treated as zero implicitly. With binutils-2.17, the crc
> > symbol gets dropped, and any module trying to use it will fail to
> > load.
> > 
> > This sets the weak CRC symbol to zero explicitly, making it defined
> > in vmlinux, which in turn lets us load the modules referring to
> > that CRC.
> > 
> > The comment above the __CRC_SYMBOL macro suggests that this was
> > always the intention, although it also seems that all symbols
> > defined in C have a correct CRC these days, and only the exports
> > that are now done in assembly need this.
> > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if this is the correct way of doing it, but this seems trivial
> > enough and lets me build the kernel with missing CRCs with any binutils
> > version.
> 
> I tried this along with Adam's patch on x86_64, with Debian's binutils
> 2.27.51.20161127.  The result was that the kernel's __kcrctab held 0
> for several symbols, even though there was type information in asm-
> prototypes.h and Module.symvers and the modules had a non-zero CRC for
> those symbols.  With just Adam's patch, the kernel and modules agreed.

Can you be more specific? Which symbols are those? I would have expected
modpost to generate Module.symvers from the vmlinux file, so I wonder
where that difference comes from.

	Arnd
