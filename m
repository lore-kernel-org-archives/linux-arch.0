From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 14/23] make section names compatible with
	-ffunction-sections -fdata-sections: parisc
Date: Wed, 2 Jul 2008 18:06:34 +0300
Message-ID: <20080702150634.GD4196@cs181140183.pp.htv.fi>
References: <200807020239.11410.vda.linux@googlemail.com> <1214955660.3316.31.camel@localhost.localdomain> <200807020200.49518.vda.linux@googlemail.com> <1214988107.10393.444.camel@pmac.infradead.org> <20080702145514.GC4196@cs181140183.pp.htv.fi> <1215010662.10393.459.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1215010662.10393.459.camel@pmac.infradead.org>
Sender: linux-embedded-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 02, 2008 at 03:57:42PM +0100, David Woodhouse wrote:
> On Wed, 2008-07-02 at 17:55 +0300, Adrian Bunk wrote:
> > On Wed, Jul 02, 2008 at 09:41:47AM +0100, David Woodhouse wrote:
> > > On Wed, 2008-07-02 at 02:00 +0200, Denys Vlasenko wrote:
> > > > On Wednesday 02 July 2008 01:41, James Bottomley wrote:
> > > > > On Wed, 2008-07-02 at 02:39 +0200, Denys Vlasenko wrote:
> > > > > > The purpose of this patch is to make kernel buildable
> > > > > > with "gcc -ffunction-sections -fdata-sections".
> > > > > > This patch fixes parisc architecture.
> > > > > > 
> > > > > > Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
> > > > > 
> > > > > Um ... if you look at the Makefile you'll see we already build parisc
> > > > > with -ffunction-sections; we have to: our relative jumps are too small
> > > > > to guarantee finding the stubs in large files.
> > > > > 
> > > > > Since our text is -ffunction-sections compatible already, I question the
> > > > > need for transformations like this:
> > > 
> > > We've been building FR-V kernels with --gc-sections for a long time,
> > > too.
> > >...
> > 
> > Is there any specific reason why it's not done in the upstream kernel?
> 
> Isn't it? I thought it was.
>...

It is in the Makefile, but only enabled through a nonexisting 
CONFIG_GC_SECTIONS option.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
