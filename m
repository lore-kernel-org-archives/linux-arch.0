From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] futex: remove duplicated code
Date: Mon, 15 May 2017 14:16:45 +0100
Message-ID: <20170515131644.GA3605@arm.com>
References: <20170515130742.18357-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170515130742.18357-1-jslaby@suse.cz>
Sender: linux-hexagon-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi Jiri,

On Mon, May 15, 2017 at 03:07:42PM +0200, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).

Whilst I think this is a good idea, the code in question actually results
in undefined behaviour per the C spec and is reported by UBSAN. See my
patch fixing arm64 here (which I'd forgotten about):

https://www.spinics.net/lists/linux-arch/msg38564.html

But, as stated in the thread above, I think we should go a step further
and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
appear to be used by userspace, and this whole thing is a total mess.

Any thoughts?

Will
