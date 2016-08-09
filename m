Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56566 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbcHIDz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2016 23:55:27 -0400
Date: Tue, 9 Aug 2016 05:55:08 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC v3 07/13] tables.h: add linker table support
Message-ID: <20160809035508.GC11445@nazgul.tnic>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <1469222687-1600-8-git-send-email-mcgrof@kernel.org>
 <20160729100630.GA27271@nazgul.tnic>
 <20160808150539.GG3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160808150539.GG3296@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com
Message-ID: <20160809035508.GuNRZHbY1Jt8s2oWVo0OC3KkkoSeqY4nBoKMZiuUIfI@z>

On Mon, Aug 08, 2016 at 05:05:39PM +0200, Luis R. Rodriguez wrote:
> > So how can I disable those table-* things from even getting built? Avoid
> > using table-y? But then everything declared table-y will be built
> > unconditionally. I don't think I like that. :-\
> 
> I suppose we could make this configurable... But frankly I would prefer to
> instead just document that this use should be carefully considered instead,
> and let this be up to the maintainers. We can make it easily configurable so
> we can do that later becomes a required, I don't think its needed though
> given maintainers should use it only when needed.

You know how maintainers are just people, right? At least in most cases :-)

I think it would be better if it were machine-enforceable somehow.
Maybe allow it only for core code and have a single, per-arch file
arch/x86/linker_tables or so where all those statements are collected
and can be eyeballed by more people. Dunno, just trying to think of
something here...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
