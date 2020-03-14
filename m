From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND PATCH v2 1/9] iomap: Constify ioreadX() iomem argument
 (as in generic implementation)
Date: Sat, 14 Mar 2020 12:02:58 +0100
Message-ID: <20200314110258.GA16135@kozik-lap>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200219175007.13627-2-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Wang <jasowang@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Nick
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 19, 2020 at 06:49:59PM +0100, Krzysztof Kozlowski wrote:
> The ioreadX() and ioreadX_rep() helpers have inconsistent interface.  On
> some architectures void *__iomem address argument is a pointer to const,
> on some not.
> 
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

This patch touches multipel file systems so no one is brave enough to
pick it up. However you are mentioned as maintainer of generic asm
headers so maybe you could apply it to arm-soc?

Best regards,
Krzysztof


> 
> ---
> 
> Changes since v1:
> 1. Constify also ioreadX_rep() and mmio_insX(),
> 2. Squash lib+alpha+powerpc+parisc+sh into one patch for bisectability,
> 3. Add Geert's review.
> 4. Add Arnd's review.
> ---
>  arch/alpha/include/asm/core_apecs.h   |  6 +--
>  arch/alpha/include/asm/core_cia.h     |  6 +--
>  arch/alpha/include/asm/core_lca.h     |  6 +--
>  arch/alpha/include/asm/core_marvel.h  |  4 +-
>  arch/alpha/include/asm/core_mcpcia.h  |  6 +--
>  arch/alpha/include/asm/core_t2.h      |  2 +-
>  arch/alpha/include/asm/io.h           | 12 ++---
>  arch/alpha/include/asm/io_trivial.h   | 16 +++---
>  arch/alpha/include/asm/jensen.h       |  2 +-
>  arch/alpha/include/asm/machvec.h      |  6 +--
>  arch/alpha/kernel/core_marvel.c       |  2 +-
>  arch/alpha/kernel/io.c                | 12 ++---
>  arch/parisc/include/asm/io.h          |  4 +-
>  arch/parisc/lib/iomap.c               | 72 +++++++++++++--------------
>  arch/powerpc/kernel/iomap.c           | 28 +++++------
>  arch/sh/kernel/iomap.c                | 22 ++++----
>  include/asm-generic/iomap.h           | 28 +++++------
>  include/linux/io-64-nonatomic-hi-lo.h |  4 +-
>  include/linux/io-64-nonatomic-lo-hi.h |  4 +-
>  lib/iomap.c                           | 30 +++++------
>  20 files changed, 136 insertions(+), 136 deletions(-)
> 
