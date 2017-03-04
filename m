From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] futex: remove duplicated code
Date: Sat, 04 Mar 2017 23:49:44 +1100
Message-ID: <877f45cil2.fsf@concordia.ellerman.id.au>
References: <20170303122712.13353-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

Jiri Slaby <jslaby@suse.cz> writes:

> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
>
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.

Looks OK and boots on powerpc. But I don't think anything's actually
calling those futex ops. Is there a test suite I should run?

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
