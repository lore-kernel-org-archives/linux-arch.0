From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Subject: Re: [PATCH 03/20] asm-generic: Drop getrlimit and setrlimit
 syscalls from default list
Date: Fri, 13 Jan 2017 10:51:44 +0800 (CST)
Message-ID: <16049.175.43.247.167.1484275904.squirrel@mprc.pku.edu.cn>
References: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
 <1483961397-8599-4-git-send-email-ynorov@caviumnetworks.com>
Reply-To: gxt@mprc.pku.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483961397-8599-4-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
Cc: linux-doc@vger.kernel.org, Andrew Pinski <andrew.pinski@caviumnetworks.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Metcalf <cmetcalf@ezchip.com>, Yury Norov <ynorov@caviumnetworks.com>, linux@lists.openrisc.net, linux-hexagon@vger.kernel.org, philipp.tomsich@theobroma-systems.com, Joseph Myers <joseph@codesourcery.com>, linux-arch@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, zhouchengming1@huawei.com, Guan Xuetao <gxt@mprc.pku.edu.cn>, Steve Ellcey <sellcey@caviumnetworks.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, prasun.kapoor@caviumnetworks.com, Andreas Schwab <schwab@suse.de>, Aurelien Jacquiot <a-jacquiot@ti.com>, agraf@suse.de, szabolcs.nagy@arm.com, geert@linux-m68k.org, Lennox Wu <lennox.wu@gmail.com>, Mark Salter <msalter@redhat.com>, linux-snps-arc@lists.infradead
List-Id: linux-arch.vger.kernel.org

> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
>
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures
> using the generic syscall list to define it so that no in-tree
> architectures
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

For UniCore32:
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Thanks.
