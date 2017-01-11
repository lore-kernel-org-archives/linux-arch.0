Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60827 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967328AbdAKOha (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jan 2017 09:37:30 -0500
Date: Wed, 11 Jan 2017 15:37:22 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v6 00/14] linux: generalize sections, ranges and linker
 tables
Message-ID: <20170111143722.GM13946@wotan.suse.de>
References: <20161222023811.21246-1-mcgrof@kernel.org>
 <20170109145833.11502-1-mcgrof@kernel.org>
 <1483979228.26691.40.camel@linux.intel.com>
 <1483981946.26691.44.camel@intel.com>
 <1483986555.26691.46.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1483986555.26691.46.camel@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170111143722.y4HV3qMpzfuc3AIbIe3j27FFQvY921g4pfY2AVQd-Rk@z>

On Mon, Jan 09, 2017 at 08:29:15PM +0200, Andy Shevchenko wrote:
> On Mon, 2017-01-09 at 19:12 +0200, Andy Shevchenko wrote:
> > On Mon, 2017-01-09 at 18:27 +0200, Andy Shevchenko wrote:
> > > On Mon, 2017-01-09 at 06:58 -0800, Luis R. Rodriguez wrote:
> > > > The only architecture that was not tested was avr32 and that is
> > > > because
> > > > linux-next fails to compile on it. I'd like to greatly thank
> > > > Guenter
> > > > Roeck for
> > > > his help with testing.
> > > 
> > > We have a real board here. I would try to check if you provide a git
> > > url
> > > to your stuff.
> > > 
> > > I can confirm that breakage happened like in last couple of month.
> > > v4.10-rc3 can't be compiled either.
> > 
> > The culprit commit is
> > 
> > commit 3a0af8fd61f90920f6fa04e4f1e9a6a73c1b4fd2
> > Author: Thomas Graf <tgraf@suug.ch>
> > Date:   Wed Nov 30 17:10:10 2016 +0100
> > 
> >     bpf: BPF for lightweight tunnel infrastructure
> > 
> 
> This makes modules closer to each other, so,
> net/socket.c:348: relocation truncated to fit: R_AVR32_11H_PCREL against
> `.text'+2930
> 
> But still the module is too big for AVR to do some jumps.

Well I've reverted your patch and tested on avr32 and all tests
worked successfully. Thanks to Guenter again for helping with his
testbed once again!

  Luis
