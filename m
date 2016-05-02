Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50818 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbcEBNZd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2016 09:25:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] asm-generic: Drop renameat syscall from default list
Date: Mon, 02 May 2016 15:23:12 +0200
Message-ID: <5769874.XvA4zrbPZs@wuerfel>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
References: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com> <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Chen Liqin <liqin.linux@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Richard Kuo <rkuo@codeaurora.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ley Foon Tan <lftan@altera.com>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>
Message-ID: <20160502132312.tM_PhzN146I3FG598hNCx1reHXB67JN-V6d9o7mXi6o@z>

On Monday 02 May 2016 05:13:46 Vineet Gupta wrote:
> On Saturday 30 April 2016 02:59 AM, James Hogan wrote:
> > The newer renameat2 syscall provides all the functionality provided by
> > the renameat syscall and adds flags, so future architectures won't need
> > to include renameat.
> >
> > Therefore drop the renameat syscall from the generic syscall list unless
> > __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> > including asm-generic/unistd.h, and adjust all architectures using the
> > generic syscall list to define it so that no in-tree architectures are
> > affected.
> >
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>  # for arch/arc

Applied to the asm-generic, tree, thanks!

	Arnd
