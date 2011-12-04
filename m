From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Mon, 05 Dec 2011 09:41:55 +1100
Message-ID: <1323038515.11728.26.camel@pasglop>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
         <20111204213316.GB14542@n2100.arm.linux.org.uk>
         <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
         <20111204221850.GC14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sven Eckelmann <sven@narfation.org>, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergma nn <arnd@arnd>
List-Id: linux-arch.vger.kernel.org

On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:

 .../...

> And really, I believe it would be a good cleanup if all the standard
> definitions for atomic64 ops (like atomic64_add_negative) were also
> defined in include/linux/atomic.h rather than individually in every
> atomic*.h header throughout the kernel source, except where an arch
> wants to explicitly override it.  Yet again, virtually all architectures
> define these in exactly the same way.
> 
> We have more than enough code in arch/ for any architecture to worry
> about, we don't need schemes to add more when there's simple and
> practical solutions to avoiding doing so if the right design were
> chosen (preferably from the outset.)
> 
> So, I'm not going to offer my ack for a change which I don't believe
> is the correct approach.

I agree with Russell, his approach is a lot easier to maintain long run,
we should even consider converting existing definitions.

Cheers,
Ben.
