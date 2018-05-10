From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Date: Thu, 10 May 2018 01:24:26 +0000
Message-ID: <20180510012426.GA27853@wotan.suse.de>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <CAMuHMdUpc6=j62E7Xrcid6tKU5FRUZsiSVK7J=KD09epQ=9xfA@mail.gmail.com>
 <20180502151113.GB27853@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502151113.GB27853@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <mawilcox@microsoft.com>, Greg KH <gregkh@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 03:11:13PM +0000, Luis R. Rodriguez wrote:
> On Wed, May 02, 2018 at 12:08:57PM +0200, Geert Uytterhoeven wrote:
> > Hi Luis,
> > 
> > On Sat, Apr 28, 2018 at 2:15 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Some architectures do not define PAGE_KERNEL_RO, best we can do
> > > for them is to provide a fallback onto PAGE_KERNEL. Remove the
> > > hack from the firmware loader and move it onto the asm-generic
> > > header, and document while at it the affected architectures
> > > which do not have a PAGE_KERNEL_RO:
> > >
> > >   o alpha
> > >   o ia64
> > >   o m68k
> > >   o mips
> > >   o sparc64
> > >   o sparc
> > >
> > > Blessed-by: 0-day
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > 
> > I believe the "best we can do" is to add the missing definitions for the
> > architectures where the hardware does support it?
> 
> True, but we cannot wait for every architecture to implement a feature to then
> such generics upstream, 

Come to think of it your point was the wording. I changed it to not be as misleading.

  Luis
