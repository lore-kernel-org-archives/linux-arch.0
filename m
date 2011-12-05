From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Mon, 05 Dec 2011 19:26:55 +1100
Message-ID: <1323073615.660.11.camel@pasglop>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
         <20111204221850.GC14542@n2100.arm.linux.org.uk>
         <1323038515.11728.26.camel@pasglop>
         <3836467.I5Tqg6MFf9@sven-laptop.home.narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <3836467.I5Tqg6MFf9@sven-laptop.home.narfation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sven Eckelmann <sven@narfation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd
List-Id: linux-arch.vger.kernel.org

On Mon, 2011-12-05 at 08:57 +0100, Sven Eckelmann wrote:
> On Monday 05 December 2011 09:41:55 Benjamin Herrenschmidt wrote:
> > On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:
> > 
> >  .../...
> > 
> > > And really, I believe it would be a good cleanup if all the standard
> > > definitions for atomic64 ops (like atomic64_add_negative) were also
> > > defined in include/linux/atomic.h rather than individually in every
> > > atomic*.h header throughout the kernel source, except where an arch
> > > wants to explicitly override it.  Yet again, virtually all architectures
> > > define these in exactly the same way.
> > > 
> > > We have more than enough code in arch/ for any architecture to worry
> > > about, we don't need schemes to add more when there's simple and
> > > practical solutions to avoiding doing so if the right design were
> > > chosen (preferably from the outset.)
> > > 
> > > So, I'm not going to offer my ack for a change which I don't believe
> > > is the correct approach.
> > 
> > I agree with Russell, his approach is a lot easier to maintain long run,
> > we should even consider converting existing definitions.
> 
> I would rather go with "the existing definitions have to converted" and this 
> means "not by this patch".

Right. I didn't suggest -you- had to do it as a pre-req to your patch.

>  At the moment, the atomic64 stuff exist only as 
> separate generic or arch specific implementation. It is fine that Russell King 
> noticed that people like Arun Sharma did a lot of work to made it true for 
> atomic_t, but atomic64_t is a little bit different right now (at least as I 
> understand it).

Cheers,
Ben.
