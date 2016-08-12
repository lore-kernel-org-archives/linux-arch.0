From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC v3 07/13] tables.h: add linker table support
Date: Fri, 12 Aug 2016 22:46:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608122244130.22028@cbobk.fhfr.pm>
References: <20160729100630.GA27271@nazgul.tnic> <20160808150539.GG3296@wotan.suse.de> <20160809035508.GC11445@nazgul.tnic> <20160812035129.GA3296@wotan.suse.de> <20160812052303.GB12013@nazgul.tnic> <20160812065011.GB3296@wotan.suse.de> <20160812072507.GC12013@nazgul.tnic>
 <20160812152805.GD3296@wotan.suse.de> <20160812155121.GB13315@nazgul.tnic> <20160812170451.GE3296@wotan.suse.de> <20160812202334.GA10199@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20160812202334.GA10199@kroah.com>
Sender: sparclinux-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.
List-Id: linux-arch.vger.kernel.org

On Fri, 12 Aug 2016, Greg KH wrote:

> > +	  Enabling this option never increases the size of your kernel.
> 
> Then what does it do?  Just burn electricity for no reason?

I think that this whole thing could be without loss of generality 
reformulated in a "allows for participating in compile-testing code 
efforts, without actually having to have all the compile-tested code 
present in the resulting kernel".

-- 
Jiri Kosina
SUSE Labs

