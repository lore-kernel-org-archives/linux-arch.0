Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60657 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbcHYSE4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Aug 2016 14:04:56 -0400
Date: Thu, 25 Aug 2016 19:52:39 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core helpers
Message-ID: <20160825175239.GB3296@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642454-5679-5-git-send-email-mcgrof@kernel.org>
 <20160823112633.7d482e62@roar.ozlabs.ibm.com>
 <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20160825175239.FD3GRpwfTLKOY3dmtJLUwoIzSNR9xPm0pvFV9Ltfl2A@z>

On Thu, Aug 25, 2016 at 04:51:21PM +1000, Nicholas Piggin wrote:
> On Thu, 25 Aug 2016 08:05:40 +0200
> "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> > > Oh, that makes more sense. The SECTION stuff and custom sections was
> > > confusing me. I would prefer just to drop all the LINUX_SECTION naming
> > > and make it match the functionality you're using. For example:
> > > 
> > > +DEFINE_LINKTABLE(struct jump_entry, __jump_table);
> > > +
> > >  /* mutex to protect coming/going of the the jump_label table */
> > >  static DEFINE_MUTEX(jump_label_mutex);
> > >  
> > > @@ -274,8 +277,6 @@ static void __jump_label_update(struct static_key *key,
> > >  
> > >  void __init jump_label_init(void)
> > >  {
> > > -	struct jump_entry *iter_start = __start___jump_table;
> > > -	struct jump_entry *iter_stop = __stop___jump_table;
> > >  	struct static_key *key = NULL;
> > >  	struct jump_entry *iter;
> > >  
> > > @@ -292,9 +293,10 @@ void __init jump_label_init(void)
> > >  		return;
> > >  
> > >  	jump_label_lock();
> > > -	jump_label_sort_entries(iter_start, iter_stop);
> > > +	jump_label_sort_entries(LINUX_SECTION_START(__jump_table),
> > > +				LINUX_SECTION_END(__jump_table));
> > > 
> > > Now I think this is a fine abstraction to have.  
> > 
> > OK will keep this one.
> > 
> > > I think it would look
> > > even cleaner if you had:
> > > 
> > > LINKTABLE_START(__jump_table)
> > > LINKTABLE_END(__jump_table)
> > >
> > > Then do we need to even have the LINUX_SECTION middle man at all?  
> > 
> > Ah, thing is we use this for both linktables and section ranges.
> > Or do we want macros for both that do the same thing ?
> 
> I think it would make the code using it more readable.

Alrighty... so:

LINKTABLE_START()
LINKTABLE_END()

SECTION_RANGE_START()
SECTION_RANGE_END()

And these macros do the exact same thing. Ie, nothing shared. Right?

  Luis
