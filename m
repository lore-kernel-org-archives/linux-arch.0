Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50936 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcGVW04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Jul 2016 18:26:56 -0400
Date: Sat, 23 Jul 2016 00:26:54 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v3 10/13] jump_label: port __jump_table to linker tables
Message-ID: <20160722222654.GO5537@wotan.suse.de>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <1469222687-1600-11-git-send-email-mcgrof@kernel.org>
 <20160722214945.h7v7fvsnuhnvz6ux@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160722214945.h7v7fvsnuhnvz6ux@treble>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org
Message-ID: <20160722222654.0o99HOlTLOJv8yPvS4-C-ZydL1EkB-u1imaPRahJf1I@z>

On Fri, Jul 22, 2016 at 04:49:45PM -0500, Josh Poimboeuf wrote:
> On Fri, Jul 22, 2016 at 02:24:44PM -0700, Luis R. Rodriguez wrote:
> > diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> > index bff8abb3a4aa..f0ad369f994b 100644
> > --- a/tools/objtool/special.c
> > +++ b/tools/objtool/special.c
> > @@ -26,6 +26,10 @@
> >  #include "special.h"
> >  #include "warn.h"
> >  
> > +#include "../../include/asm-generic/sections.h"
> > +#include "../../include/asm-generic/tables.h"
> > +#include "../../include/linux/stringify.h"
> > +
> >  #define EX_ENTRY_SIZE		12
> >  #define EX_ORIG_OFFSET		0
> >  #define EX_NEW_OFFSET		4
> > @@ -63,7 +67,9 @@ struct special_entry entries[] = {
> >  		.feature = ALT_FEATURE_OFFSET,
> >  	},
> >  	{
> > -		.sec = "__jump_table",
> > +		.sec = __stringify(SECTION_TBL(SECTION_DATA,
> > +				               __jump_table,
> > +					       SECTION_ORDER_ANY)),
> >  		.jump_or_nop = true,
> >  		.size = JUMP_ENTRY_SIZE,
> >  		.orig = JUMP_ORIG_OFFSET,
> 
> (continuing our discussion from another thread...)
> 
> I think tools code isn't allowed to include kernel files because the
> tools subdirectory is supposed to be completely independent.

That was also the case for userpsace tools in scripts/ -- for instance
scripts/mod/modpost.c made an exception. What I've proposed here to
keep things simple was to ensure -UKERNEL is passed and then only
include files we know will work.

Refer to the patch "kprobes: port .kprobes.text to section range"
in this series for an extension of the scripts/mod/modpost.c kernel
headers use.

> As far as I can tell, the section name will always be
> ".data.tbl.__jump_table.any".  Is that true?  If so, any reason why we
> can't just hard-code the string here?

Its a fair strategy, however if upstream changes the order name we'd
have to hand code this as well, by using a macro we keep it all in one
place.

> As you saw, if the string
> changes, objtool will complain and 0-day will report it.

Indeed, which is why I was hoping to instead stick to a standard
sections set of header files that lets us get these in on place.
The only place I hand coded in this series was in the perl
file scripts/recordmcount.pl but I suppose if we wanted to get
creative we could even generate a header for it too.

If we want to avoid all this hacker include stuff another option
is to *generate* each respective sections.h for the kernel, and
also, one for tools, and one for perl. What do you think?

  Luis
