Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:64100
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751690AbdFGSsY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 14:48:24 -0400
Date: Wed, 7 Jun 2017 21:48:09 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 03/20] asm-generic: Drop getrlimit and setrlimit syscalls
 from default list
Message-ID: <20170607184809.e4hmsvewkrmigmww@yury-thinkpad>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-4-ynorov@caviumnetworks.com>
 <20170605144406.GT6973@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605144406.GT6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Adam Borowski <kilobyte@angband.pl>, Chris Metcalf <cmetcalf@ezchip.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Florian Weimer <fweimer@redhat.com>, Bamvor Zhangjian <bamvor.zhangjian@huawei.com>, Andreas Schwab <schwab@suse.de>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, schwidefsky@de.ibm.com, broonie@kernel.org, Joseph Myers <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zhouchengming1@huawei.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp
Message-ID: <20170607184809.dstnZnQuz9Gwd-PwkjAidZCZS05JIBSVqiF0qalRuRs@z>

On Mon, Jun 05, 2017 at 03:44:06PM +0100, James Hogan wrote:
> Hi Yury,
> 
> On Sun, Jun 04, 2017 at 02:59:52PM +0300, Yury Norov wrote:
> > The newer prlimit64 syscall provides all the functionality provided by
> > the getrlimit and setrlimit syscalls and adds the pid of target process,
> > so future architectures won't need to include getrlimit and setrlimit.
> > 
> > Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> > list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> > unistd.h prior to including asm-generic/unistd.h, and adjust all architectures
> > using the generic syscall list to define it so that no in-tree architectures
> > are affected.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: James Hogan <james.hogan@imgtec.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Mark Salter <msalter@redhat.com>
> > Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> > Cc: linux-c6x-dev@linux-c6x.org
> > Cc: Richard Kuo <rkuo@codeaurora.org>
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: linux-metag@vger.kernel.org
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: linux@lists.openrisc.net
> > Cc: Chen Liqin <liqin.linux@gmail.com>
> > Cc: Lennox Wu <lennox.wu@gmail.com>
> > Cc: Chris Metcalf <cmetcalf@mellanox.com>
> > Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: nios2-dev@lists.rocketboards.org
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: uclinux-h8-devel@lists.sourceforge.jp
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Mark Salter <msalter@redhat.com> [c6x]
> > Acked-by: James Hogan <james.hogan@imgtec.com> [metag]
> > Acked-by: Ley Foon Tan <lftan@altera.com> [nios2]
> > Acked-by: Stafford Horne <shorne@gmail.com> [openrisc]
> > Acked-by: Will Deacon <will.deacon@arm.com> [arm64]
> > Acked-by: Vineet Gupta <vgupta@synopsys.com> #arch/arc bits
> > ---
> >  arch/arc/include/uapi/asm/unistd.h       | 1 +
> >  arch/arm64/include/uapi/asm/unistd.h     | 1 +
> >  arch/c6x/include/uapi/asm/unistd.h       | 1 +
> >  arch/h8300/include/uapi/asm/unistd.h     | 1 +
> >  arch/hexagon/include/uapi/asm/unistd.h   | 1 +
> >  arch/metag/include/uapi/asm/unistd.h     | 1 +
> >  arch/nios2/include/uapi/asm/unistd.h     | 1 +
> >  arch/openrisc/include/uapi/asm/unistd.h  | 1 +
> >  arch/score/include/uapi/asm/unistd.h     | 1 +
> >  arch/tile/include/uapi/asm/unistd.h      | 1 +
> >  arch/unicore32/include/uapi/asm/unistd.h | 1 +
> >  include/uapi/asm-generic/unistd.h        | 5 +++++
> 
> Don't forget to add __IGNORE_getrlimit and __IGNORE_setrlimit to
> scripts/checksyscalls.sh, or you'll get warnings about missing syscalls.
> 
> Cheers
> James

Hi James,

Thanks for the hint.

Yury
