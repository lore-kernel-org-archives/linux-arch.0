From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Date: Tue, 17 Jun 2008 14:37:17 +0200
Message-ID: <20080617123717.GC10598@uranus.ravnborg.org>
References: <1213604973-7073-1-git-send-email-jacmet@sunsite.dk> <1213617663.26255.708.camel@pmac.infradead.org> <20080616121727.GB10854@cs181133002.pp.htv.fi> <1213619214.26255.721.camel@pmac.infradead.org> <20080617084235.GA20169@cs181133002.pp.htv.fi> <1213696004.26255.960.camel@pmac.infradead.org> <20080617101112.GE20169@cs181133002.pp.htv.fi> <1213702113.26255.996.camel@pmac.infradead.org> <20080617122346.GA10598@uranus.ravnborg.org> <1213705749.26255.1027.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1213705749.26255.1027.camel@pmac.infradead.org>
Sender: linux-sh-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@kernel.org>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 17, 2008 at 01:29:09PM +0100, David Woodhouse wrote:
> On Tue, 2008-06-17 at 14:23 +0200, Sam Ravnborg wrote:
> > Sorting these alphabetically will result in less merge conflicts when
> > the list grows.
> 
> Maybe, but it doesn't grow that fast -- and it's small enough that if I
> add stuff in the middle, the context will cover the whole thing and
> cause a merge conflict either way. And it isn't in alphabetical order
> now either :)
I know and I know.
If someone did the janitorial effort and converted all the
per-arch defined symbols to one single definiton
and select the list would grow rapidly.

	Sam
