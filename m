Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42559 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964925AbcHJSxq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Aug 2016 14:53:46 -0400
Date: Wed, 10 Aug 2016 19:03:29 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v3 00/13] linux: generalize sections, ranges and linker
 tables
Message-ID: <20160810170329.GK3296@wotan.suse.de>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160809152429.5bb1c077@lxorguk.ukuu.org.uk>
 <1470758947.2299.47.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470758947.2299.47.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com, msalter@redhat.com, a-jacquiot@ti.com
Message-ID: <20160810170329.Ct59bIir6DaVHGIrkAsNp4RBLzEP-BN7_X0H2JDU-0A@z>

On Tue, Aug 09, 2016 at 09:09:07AM -0700, James Bottomley wrote:
> On Tue, 2016-08-09 at 15:24 +0100, One Thousand Gnomes wrote:
> > > table development go under copyleft-next, Rusty recently asked for 
> > > code to go in prior to the license tag being added denoting this 
> > > license as GPL-compatible [3] -- I had noted in the patch 
> > > submission which annotated copyleft-next's compatibility to GPLv2 
> > > that copyleft-next is the license of choice for ongoing kernel 
> > > development on my end [4]. If this is objectionable I'm happy to 
> > > change it to GPLv2 however I'd like a reason provided as I've gone 
> > > through all possible channels to ensure this is kosher, including
> > > vetting by 3 attorneys now, 2 at SUSE.
> > 
> > You don't need a new tag, you can use "GPL" or "GPL and additional
> > rights". In fact you don't want any other tag because when combined
> >  with the kernel it is GPLv2 anyway because the only way the two are 
> > fully compatible is for the kernel community to license the derived 
> > work under the GPL.
> 
> This is the module tag ... it says what licence the module is under,
> not the licence for the module combined with the kernel, which is
> always GPLv2 because the stricter licence rules.

As per Linus' recommendations [0] if I add a module I'll be using
MODULE_LICENSE("GPL") if using copyleft-next. Either way this series
didn't add a module yet so no need for that yet, but it does use
copyleft-next in headers / C code.

[0] https://lkml.kernel.org/r/CA+55aFyhxcvD+q7tp+-yrSFDKfR0mOHgyEAe=f_94aKLsOu0Og@mail.gmail.com

> However, if I
> want my binary only modules to be combined with Linux, I have to follow
> GPLv2 compliance because GPLv2 becomes the ruling licence of the
> combination.  The same would apply to this copyleft-next, even after 15
> years.

And this what really matters here.

> The US copyright office defines a copyright work as anything which is
> "an original work of authorship fixed in any tangible medium of
> expression".  That means any change to an existing work (i.e. by a
> patch) which contains enough originality to make the changed work
> distinct from the old work is ipso facto a new work.  under copyright
> -next this new work has a sunset 15 years from its creation by
> combination, not 15 years from the original.  This means a constantly
> updated work never sunsets.  Sure, you can go back 15 years and claim
> the code at that time has passed into the public domain but you can't
> do that if you also want the benefit of later changes.

Agreed.

  Luis
