From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] asm-generic: Drop renameat syscall from default list
Date: Mon, 2 May 2016 05:13:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
References: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-hexagon-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Richard Kuo <rkuo@codeaurora.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, "linux@lists.openrisc.net" <linux@lists.openrisc.net>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ley Foon Ta
List-Id: linux-arch.vger.kernel.org

On Saturday 30 April 2016 02:59 AM, James Hogan wrote:
> The newer renameat2 syscall provides all the functionality provided by
> the renameat syscall and adds flags, so future architectures won't need
> to include renameat.
>
> Therefore drop the renameat syscall from the generic syscall list unless
> __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> including asm-generic/unistd.h, and adjust all architectures using the
> generic syscall list to define it so that no in-tree architectures are
> affected.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-metag@vger.kernel.org
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux@lists.openrisc.net
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> ---
> I just found this patch on an old branch, it appears to have slipped
> through the cracks. Time for a respon.
>
> Changes in v2:
> - Rebase onto v4.6-rc5.
> - Add __ARCH_WANT_RENAMEAT to h8300 and nios2 arches too.
> ---
>  arch/arc/include/uapi/asm/unistd.h       | 1 +

Acked-by: Vineet Gupta <vgupta@synopsys.com>  # for arch/arc
