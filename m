From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 6/6] arch: add untagged_addr definition for other
 arches
Date: Fri, 9 Mar 2018 15:11:27 +0100
Message-ID: <CAK8P3a0NZfxoxeJbrebBmZDqQhD9s12xpUwMoM-rZzH8aezuYA@mail.gmail.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, Lee Smith <Lee.Smith@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Shaohua Li <shli@fb.com>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Evgeniy Stepanov <eugenis@google.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, adi-buildroot-devel@lists.sourceforge.net, Mike Rapoport <rppt@linux.vnet.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 9, 2018 at 3:02 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> To allow arm64 syscalls accept tagged pointers from userspace, we must
> untag them when they are passed to the kernel. Since untagging is done in
> generic parts of the kernel (like the mm subsystem), the untagged_addr
> macro should be defined for all architectures.
>
> Define it as a noop for all other architectures besides arm64.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/alpha/include/asm/uaccess.h      | 2 ++
>  arch/arc/include/asm/uaccess.h        | 1 +
>  arch/arm/include/asm/uaccess.h        | 2 ++
>  arch/blackfin/include/asm/uaccess.h   | 2 ++
>  arch/c6x/include/asm/uaccess.h        | 2 ++
>  arch/cris/include/asm/uaccess.h       | 2 ++
>  arch/frv/include/asm/uaccess.h        | 2 ++
>  arch/ia64/include/asm/uaccess.h       | 2 ++
>  arch/m32r/include/asm/uaccess.h       | 2 ++
>  arch/m68k/include/asm/uaccess.h       | 2 ++
>  arch/metag/include/asm/uaccess.h      | 2 ++
>  arch/microblaze/include/asm/uaccess.h | 2 ++
>  arch/mips/include/asm/uaccess.h       | 2 ++
>  arch/mn10300/include/asm/uaccess.h    | 2 ++
>  arch/nios2/include/asm/uaccess.h      | 2 ++
>  arch/openrisc/include/asm/uaccess.h   | 2 ++
>  arch/parisc/include/asm/uaccess.h     | 2 ++
>  arch/powerpc/include/asm/uaccess.h    | 2 ++
>  arch/riscv/include/asm/uaccess.h      | 2 ++
>  arch/score/include/asm/uaccess.h      | 2 ++
>  arch/sh/include/asm/uaccess.h         | 2 ++
>  arch/sparc/include/asm/uaccess.h      | 2 ++
>  arch/tile/include/asm/uaccess.h       | 2 ++
>  arch/x86/include/asm/uaccess.h        | 2 ++
>  arch/xtensa/include/asm/uaccess.h     | 2 ++
>  include/asm-generic/uaccess.h         | 2 ++
>  26 files changed, 51 insertions(+)

I have patches to remove the blackfin, cris, frv, m32r, metag, mn10300,
score, tile and unicore32 architectures from the kernel, these should be
part of linux-next in the next few days. It's not a big issue, but if you keep
patching them, this will cause a merge conflict.

It might be easier to drop them from your patch as well.

    Arnd
