From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Fri, 19 Feb 2016 22:48:56 +0100
Message-ID: <20160219214856.GX25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
 <56C77A53.6060708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030273AbcBSVtB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 16:49:01 -0500
Content-Disposition: inline
In-Reply-To: <56C77A53.6060708@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com

On Fri, Feb 19, 2016 at 12:25:55PM -0800, H. Peter Anvin wrote:
> On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
> > +
> > +/**
> > + * DOC: Regular linker linker table constructors
> > + *
> > + * Regular constructors are expected to be used for valid linker table entries.
> > + * Valid uses of weak entries other than the beginning and is currently
> > + * untested but should in theory work.
> > + */
> > +
> > +/**
> > + * LINKTABLE_TEXT - Declares a linker table entry for execution
> > + *
> > + * @name: linker table name
> > + * @level: order level
> > + *
> > + * Declares a linker table to be used for execution.
> > + */
> > +#define LINKTABLE_TEXT(name, level)					\
> > +	      __typeof__(name[0])					\
> > +	      __attribute__((used,					\
> > +			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
> > +			     section(SECTION_TBL(SECTION_TEXT, name, level))))
> 
> I'm really confused by this.  Text should obviously be readonly, 

So this uses SECTION_TEXT, so we just pegged the linker table entry right below
the standard SECTION_TEXT:

@@ -422,7 +426,8 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT                                                      \
                ALIGN_FUNCTION();                                       \
-               *(.text.hot .text .text.fixup .text.unlikely)           \
+               *(.text.hot SECTION_TEXT .text.fixup .text.unlikely)            \
+               *(SORT(SECTION_TBL_ALL(SECTION_TEXT)))                  \
                *(.ref.text)                                            \
        MEM_KEEP(init.text)                                             \
        MEM_KEEP(exit.text) 

So this gets folded under TEXT_TEXT and we don't see to force all
architectures for this to be read-only specifically. I can't be sure
if it is always read-only for all architectures based on a cursory
review.

> but I'm not at all clear how this works here.

Its simply trying to piggy back on top of where the standard section
it is using so in this case SECTION_TEXT (.text). What attributes are
part of that follow.

> The issue with linktables for text is kind of confusing if nothing else;
> Russel is right about that.  It doesn't prevent us from doing something
> similar, but perhaps it ought to have a different name.

Any recommendations?

> For one thing, priority level is meaningless for text, since it is not a
> table that can be indexed into.

Ah right, there is no structure so we can't foo->in, let alone, know what
arguments to pass... the order level certainly would still kick in but
I agree that it would seem kind of pointless as something else would
have to know how to use it. I could simply remove the iterator and
order-level for SECTION_TEXT linker tables if we are sure we can't use it.
The only gain then here would be that of saving custom linker script
changes and having a unified way to represent the attributes.

If order is desired a structured data would would make more sense and
I could document / recommend that, however I don't yet have a ported
use case in mind yet, any ideas? The use case I have that follows
similar logic is for the x86 init stuff which I am sending separately
and that's a new use case though. It uses SECTION_INIT (.init.text)
and that allows for both use of structuralized data + callbacks we
can execute. It was not clear to me what section to use for this sort
of stuff for non init stuff, and I can envision people highly wanting
to use this to help clean up init paths on code, what sectoin
should be used in those cases?

 Luis
