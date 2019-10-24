Return-Path: <rppt@kernel.org>
Date: Thu, 24 Oct 2019 12:50:54 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-ID: <20191024095053.GC12281@rapoport-lnx>
References: <1571822941-29776-9-git-send-email-rppt@kernel.org>
 <20191024093451.15161-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024093451.15161-1-peda@axentia.se>
To: Peter Rosin <peda@axentia.se>
Cc: "James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, "arnd@arndb.de" <arnd@arndb.de>, "davem@davemloft.net" <davem@davemloft.net>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "deller@gmx.de" <deller@gmx.de>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@linux-m68k.org" <gerg@linux-m68k.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "jdike@addtoit.com" <jdike@addtoit.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "mattst88@gmail.com" <mattst88@gmail.com>, "monstr@monstr.eu" <monstr@monstr.eu>, "msalter@redhat.com" <msalter@redhat.com>, "richard@nod.at" <richard@nod.at>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "sammy@sammy.net" <sammy@sammy.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024095054.grUmS4oM5O6s3dcQhyCPDRewqYk0EU6IMQsqPVW6dIk@z>

On Thu, Oct 24, 2019 at 09:35:12AM +0000, Peter Rosin wrote:
> On 2019-10-23 12:28, Mike Rapoport <rppt@kernel.org> wrote:
> > parisc has two or three levels of page tables and can use appropriate
> > pgtable-nopXd and folding of the upper layers.
> >
> > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > definitions of __PAGETABLE_PxD_FOLDED in parisc with
> > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > include/asm-generic/pgtable-nopmd.h for three-lelve configurations and
> 
> I think you mean .../pgtable-nopud.h in the latter case.

Right, thanks!
 
> Cheers,
> Peter

-- 
Sincerely yours,
Mike.
