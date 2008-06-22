From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Date: Sun, 22 Jun 2008 12:40:50 +0100
Message-ID: <1214134850.2409.2.camel@shinybook.infradead.org>
References: <1213565555.26255.522.camel@pmac.infradead.org>
	 <1213604973-7073-1-git-send-email-jacmet@sunsite.dk>
	 <1213617663.26255.708.camel@pmac.infradead.org>
	 <20080616121727.GB10854@cs181133002.pp.htv.fi>
	 <1213619214.26255.721.camel@pmac.infradead.org>
	 <20080617084235.GA20169@cs181133002.pp.htv.fi>
	 <1213696004.26255.960.camel@pmac.infradead.org>
	 <20080617101112.GE20169@cs181133002.pp.htv.fi>
	 <1213702113.26255.996.camel@pmac.infradead.org>
	 <20080622094907.GF27069@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753353AbYFVLu1@vger.kernel.org>
In-Reply-To: <20080622094907.GF27069@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, sam@ravnborg.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, gerg@uclinux.org
List-Id: linux-arch.vger.kernel.org

On Sun, 2008-06-22 at 12:49 +0300, Adrian Bunk wrote:
> 
> What about m68knommu?
> 
> I don't know whether it was intentionally available there, but the 
> removal in your patch does not seem to be intentional.

Hm, true. Well spotted. I think it's probably correct though -- I don't
think m68knommu can really support a.out binaries, can it?

-- 
dwmw2
