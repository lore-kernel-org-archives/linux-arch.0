From: Adrian Bunk <bunk@kernel.org>
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Date: Tue, 24 Jun 2008 14:46:43 +0300
Message-ID: <20080624114643.GB16021@cs181140183.pp.htv.fi>
References: <1213604973-7073-1-git-send-email-jacmet@sunsite.dk> <1213617663.26255.708.camel@pmac.infradead.org> <20080616121727.GB10854@cs181133002.pp.htv.fi> <1213619214.26255.721.camel@pmac.infradead.org> <20080617084235.GA20169@cs181133002.pp.htv.fi> <1213696004.26255.960.camel@pmac.infradead.org> <20080617101112.GE20169@cs181133002.pp.htv.fi> <1213702113.26255.996.camel@pmac.infradead.org> <20080622094907.GF27069@cs181133002.pp.htv.fi> <1214134850.2409.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1214134850.2409.2.camel@shinybook.infradead.org>
Sender: linux-sh-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, sam@ravnborg.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, gerg@uclinux.org, jdike@addtoit.com
List-Id: linux-arch.vger.kernel.org

On Sun, Jun 22, 2008 at 12:40:50PM +0100, David Woodhouse wrote:
> On Sun, 2008-06-22 at 12:49 +0300, Adrian Bunk wrote:
> > 
> > What about m68knommu?
> > 
> > I don't know whether it was intentionally available there, but the 
> > removal in your patch does not seem to be intentional.
> 
> Hm, true. Well spotted. I think it's probably correct though -- I don't
> think m68knommu can really support a.out binaries, can it?

I found another similar case:

X86_32 UML.

a.out is most likely working there?

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

