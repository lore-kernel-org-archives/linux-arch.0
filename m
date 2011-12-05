From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Sun, 04 Dec 2011 16:14:13 -0800
Message-ID: <4EDC0CD5.2090601@zytor.com>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>  <20111204213316.GB14542@n2100.arm.linux.org.uk>  <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>  <20111204221850.GC14542@n2100.arm.linux.org.uk> <1323038515.11728.26.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1323038515.11728.26.camel@pasglop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sven Eckelmann <sven@narfation.org>, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd
List-Id: linux-arch.vger.kernel.org

On 12/04/2011 02:41 PM, Benjamin Herrenschmidt wrote:
> 
> I agree with Russell, his approach is a lot easier to maintain long run,
> we should even consider converting existing definitions.
> 

Thirded.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
