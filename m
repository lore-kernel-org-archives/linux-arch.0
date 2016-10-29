Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61962 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754996AbcJ2VzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2016 17:55:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from default list
Date: Sat, 29 Oct 2016 23:54:08 +0200
Message-ID: <5823871.3DMLUx5Xtp@wuerfel>
In-Reply-To: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Andrew Pinski <Andrew.Pinski@cavium.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-metag@vger.kernel.org, nios2-dev@lists.rocketboards.org
Message-ID: <20161029215408.YSJ_iXyMknvK7i7jKXG8PONehXnkGNDpXOiyV79CCVA@z>

On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
> 
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures using the generic syscall list to define it so that no
> in-tree architectures are affected.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you include this patch in your ilp32 series?
