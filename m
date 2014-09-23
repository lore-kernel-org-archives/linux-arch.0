From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to volatile
Date: Wed, 24 Sep 2014 03:56:39 +0400
Message-ID: <CAMo8BfKxwq=pc5Lym7X0Qdgmr37jJ-OK_dCmzukkHxtCxz8_7A@mail.gmail.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 23, 2014 at 6:29 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h    | 4 ++--
>  arch/arm/include/asm/atomic.h      | 2 +-
>  arch/arm64/include/asm/atomic.h    | 4 ++--
>  arch/avr32/include/asm/atomic.h    | 2 +-
>  arch/cris/include/asm/atomic.h     | 2 +-
>  arch/frv/include/asm/atomic.h      | 2 +-
>  arch/ia64/include/asm/atomic.h     | 4 ++--
>  arch/m32r/include/asm/atomic.h     | 2 +-
>  arch/m68k/include/asm/atomic.h     | 2 +-
>  arch/mips/include/asm/atomic.h     | 4 ++--
>  arch/parisc/include/asm/atomic.h   | 4 ++--
>  arch/sh/include/asm/atomic.h       | 2 +-
>  arch/sparc/include/asm/atomic_32.h | 2 +-
>  arch/sparc/include/asm/atomic_64.h | 4 ++--
>  arch/x86/include/asm/atomic.h      | 2 +-
>  arch/x86/include/asm/atomic64_64.h | 2 +-
>  arch/xtensa/include/asm/atomic.h   | 2 +-
>  include/asm-generic/atomic.h       | 2 +-
>  18 files changed, 24 insertions(+), 24 deletions(-)

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
