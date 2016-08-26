Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48233 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbcHZNno (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Aug 2016 09:43:44 -0400
Date: Fri, 26 Aug 2016 15:22:19 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core helpers
Message-ID: <20160826132219.GG3296@wotan.suse.de>
References: <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
 <20160825175239.GB3296@wotan.suse.de>
 <20160826130024.0ad51d33@roar.ozlabs.ibm.com>
 <CAB=NE6UQ8qE6AqRg9=YddNYrMyU7opCEij-5Usty7wMgEJJbpw@mail.gmail.com>
 <20160826173338.41a56103@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826173338.41a56103@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, benh@kernel.crashing.org, jani.nikula@intel.com, masami.hiramatsu.pt@hitachi.com, linux@rasmusvillemoes.dk, linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org, luto@amacapital.net, gnomes@lxorguk.ukuu.org.uk, jcmvbkbc@gmail.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, dwmw2@infradead.org, xen-devel@lists.xensource.com, anil.s.keshavamurthy@intel.com, will.deacon@arm.com, linux-ia64@vger.kernel.org, x86@kernel.org, korea.drzix@gmail.com, mingo@redhat.com, andrew.cooper3@citrix.com, jgross@suse.com, tglx@linutronix.de, keescook@chromium.org, ananth@linux.vnet.ibm.com, jpoimboe@redhat.com, rostedt@goodmis.org, hpa@zytor.com, acme@redhat.com, arnd@arndb.de, davem@davemloft.net, platform-driver-x86@vger.kernel.org, jkosina@suse.cz, david.vrabel@citrix.com, James.Bottomley@hansenpartnership.com, realmz6@gmail.com, fontana@sharpeleven.org, mpe@ellerman.id.au, konrad.wilk@oracle.com, ananth@in.ibm.com, paulus@samba.org, paul.gortmaker@windriver.com, pali.rohar@gmail.com, mchehab@osg.samsung.com, ak@linux.intel.com, pebolle@tiscali.nl, chris@zankel.net, jbaron@akamai.com, markus.heiser@darmarit.de, mmarek@suse.com, rusty@rustcorp.com.au, linux-xtensa@linux-xtensa.org, tony.luck@intel.com, catalin.marinas@arm.com, jolsa@kernel.org, dvhart@infradead.org, msalter@redhat.com, linux-arm-kernel@lists.infradead.org, ming.lei@canonical.com, linux@arm.linux.org.uk, andriy.shevchenko@linux.intel.com, linux-arch@vger.kernel.org, mcb30@ipxe.org, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, mhiramat@kernel.org, bp@alien8.de, sparclinux@vger.kernel.org, alan@linux.intel.com
Message-ID: <20160826132219.nzj_tB8MaZLbFfLw6UPxMCq87zOec27yisqtNEGV-0M@z>

On Fri, Aug 26, 2016 at 05:33:38PM +1000, Nicholas Piggin wrote:
> On Thu, 25 Aug 2016 23:38:44 -0700
> "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> > > > > > Ah, thing is we use this for both linktables and section ranges.
> > > > > > Or do we want macros for both that do the same thing ?  
> > > > >
> > > > > I think it would make the code using it more readable.  
> > > >
> > > > Alrighty... so:
> > > >
> > > > LINKTABLE_START()
> > > > LINKTABLE_END()
> > > >
> > > > SECTION_RANGE_START()
> > > > SECTION_RANGE_END()
> > > >
> > > > And these macros do the exact same thing. Ie, nothing shared. Right?  
> > >
> > > Yeah I think so. Internally they would probably be aliased to the
> > > same common definition (unless you had some type check or something),
> > > but user would know about such details.  
> > 
> > What name should we use for such common macro definition ?
> 
> 
> Ah, not really sure. I guess the "link table" is some kind of
> section range? I haven't actually looked closely at both of them
> in the subsequent patches. It matters less if it's not expected
> to be used as an API though.
> 

OK well, going with LINUX_SECTION_START() so we'll have:

#define LINKTABLE_START		LINUX_SECTION_START
#define LINKTABLE_END		LINUX_SECTION_END

#define SECTION_RANGE_START	LINUX_SECTION_START
#define SECTION_RANGE_END	LINUX_SECTION_END

Is that OK?

  Luis
