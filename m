From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 03/20] asm-generic: Drop getrlimit and setrlimit syscalls
 from default list
Date: Fri, 10 Mar 2017 18:09:39 +0000
Message-ID: <20170310180938.GG18894@arm.com>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
 <1488395968-14313-4-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755291AbdCJSJb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Mar 2017 13:09:31 -0500
Content-Disposition: inline
In-Reply-To: <1488395968-14313-4-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Pinski <pinskia@gmail.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Adam Borowski <kilobyte@angband.pl>, Chris Metcalf <cmetcalf@ezchip.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Florian Weimer <fweimer@redhat.com>, Bamvor Zhangjian <bamvor.zhangjian@huawei.com>, Andreas Schwab <schwab@suse.de>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, schwidefsky@de.ibm.com, broonie@kernel.org, Joseph Myers <joseph@codesourcery.com>, christoph.

On Thu, Mar 02, 2017 at 12:49:11AM +0530, Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
> 
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all architectures
> using the generic syscall list to define it so that no in-tree architectures
> are affected.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-arch@vger.kernel.org
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
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Mark Salter <msalter@redhat.com> [c6x]
> Acked-by: James Hogan <james.hogan@imgtec.com> [metag]
> Acked-by: Ley Foon Tan <lftan@altera.com> [nios2]
> Acked-by: Stafford Horne <shorne@gmail.com> [openrisc]
> Acked-by: Vineet Gupta <vgupta@synopsys.com> #arch/arc bits
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arc/include/uapi/asm/unistd.h       | 1 +
>  arch/arm64/include/uapi/asm/unistd.h     | 1 +
>  arch/c6x/include/uapi/asm/unistd.h       | 1 +
>  arch/h8300/include/uapi/asm/unistd.h     | 1 +
>  arch/hexagon/include/uapi/asm/unistd.h   | 1 +
>  arch/metag/include/uapi/asm/unistd.h     | 1 +
>  arch/nios2/include/uapi/asm/unistd.h     | 1 +
>  arch/openrisc/include/uapi/asm/unistd.h  | 1 +
>  arch/score/include/uapi/asm/unistd.h     | 1 +
>  arch/tile/include/uapi/asm/unistd.h      | 1 +
>  arch/unicore32/include/uapi/asm/unistd.h | 1 +
>  include/uapi/asm-generic/unistd.h        | 5 +++++
>  12 files changed, 16 insertions(+)

For the arm64 part:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
