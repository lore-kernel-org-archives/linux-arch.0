Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0054.outbound.protection.outlook.com ([104.47.40.54]:10579
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754996AbcJ2Vp6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Oct 2016 17:45:58 -0400
Date: Sun, 30 Oct 2016 00:45:41 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Message-ID: <20161029214541.GA20037@yury-N73SV>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
 <2502005.4risrb1P1I@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2502005.4risrb1P1I@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Andrew Pinski <Andrew.Pinski@cavium.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-metag@vger.kernel.org, nios2-dev@lists.rocketboards.org
Message-ID: <20161029214541.cT7bd4-UFEd46WiLSqVDouoHKQsTjuMcxoyLaLdaTSE@z>

On Sat, Oct 29, 2016 at 11:02:40PM +0200, Arnd Bergmann wrote:
> On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> > The newer prlimit64 syscall provides all the functionality provided by
> > the getrlimit and setrlimit syscalls and adds the pid of target process,
> > so future architectures won't need to include getrlimit and setrlimit.
> > 
> > Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> > list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> > unistd.h prior to including asm-generic/unistd.h, and adjust all
> > architectures using the generic syscall list to define it so that no
> > in-tree architectures are affected.
> 
> The patch looks good, but shouldn't we also hide the actual syscall
> implementation if the symbol is not set? It's just dead code otherwise
> for new architectures.

I was thinking on it. The patch of James Hogan, b0da6d4415 (asm-generic:
Drop renameat syscall from default list) doesn't do it for renameat(), so
I decided not to do it too. It's not so easy to disable syscalls because arch
may support few ABIs, and some of them may require the syscall. For example,
arm64 supports lp64, aarch32 and ilp32, and first two ABIs need renameat()
and getrlimit/setrlimit.

At now there's no arches that doesn't need renameat() and getrlimit/setrlimit,
and there will be no such arch in nearest future. So there will be no
dead code.

But I agree with you that we need make that implementations 
conditional. If I understand it correctly, we need something like
__ARCH_WANT_SET_GET_RLIMIT in all existing Kconfigs, correct?

I think this patch may be applied as is, and if needed I can send
another patch that disables renameat() and getrlimit/setrlimit soon.

James, what do you think?

Yury.
