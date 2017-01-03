Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757679AbdACVZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Jan 2017 16:25:34 -0500
Date: Tue, 3 Jan 2017 22:25:28 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 04/14] tables.h: add linker table support
Message-ID: <20170103212528.GE13946@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-5-mcgrof@kernel.org>
 <1482415098.9552.123.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1482415098.9552.123.camel@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, hpa@zytor.com
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170103212528.bURsqSo7r8vX8WAfOO2xQj1DSAIYdWd4_YeOj70s0MU@z>

On Thu, Dec 22, 2016 at 03:58:18PM +0200, Andy Shevchenko wrote:
> On Wed, 2016-12-21 at 18:38 -0800, Luis R. Rodriguez wrote:
> > +#define LINKTABLE_FOR_EACH(pointer, tbl)				
> 
> Hmm... SOMEONE LIKES CAPITAL LETTERS FOR everything, right? :-)
>
> I would expect more standard linktable_for_each() macro

hpa had recommended this, if he prefers a lower case I can change that
but I really do consider this bikeshedding.

> Same to the rest of similar macros.

Same answer here.

> > +/**
> > + * LINKTABLE_RUN_ERR - run each linker table entry func and return
> > error if any
> > + *
> > + * @tbl: linker table
> > + * @func: structure name for the function name we want to call.
> > + * @args...: arguments to pass to func
> > + *
> > + * Example usage::
> > + *
> > + *   unsigned int err = LINKTABLE_RUN_ERR(frobnicator_fns,
> > some_run,);
> > + */
> > +#define LINKTABLE_RUN_ERR(tbl, func, args...)				
> > \
> > +({									
> > \
> > +	size_t i;							
> > \
> > +	int err = 0;							
> > \
> > +	for (i = 0; !err && i < LINKTABLE_SIZE(tbl); i++)		
> > \
> > +		err = (LINKTABLE_START(tbl)[i]).func (args);		
> 
> 
> > \
> > +		err;							
> 
> Indentation here a bit confusing.

Ah yes, good catch, fixed.

  Luis
