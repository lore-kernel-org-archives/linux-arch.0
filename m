From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 14/17] dt: Consolidate __dtb_start declarations in <linux/of_fdt.h>
Date: Wed, 13 Nov 2013 11:11:59 +0530
Message-ID: <52831127.50302@synopsys.com>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org> <1384285347-13506-15-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:65060 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab3KMFmK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2013 00:42:10 -0500
In-Reply-To: <1384285347-13506-15-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Chris Zankel <chris@zankel.net>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org

On 11/13/2013 01:12 AM, Geert Uytterhoeven wrote:
> The different architectures used their own (and different) declarations:
> 
>     extern struct boot_param_header __dtb_start;
>     extern u32 __dtb_start[];
>     extern char __dtb_start[];
> 
> Consolidate them using the first variant in <linux/of_fdt.h>.
> This requires adding a few "address of" operators on architectures where
> __dtb_start was an array before.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> CC: Chris Zankel <chris@zankel.net>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arc/include/asm/sections.h             |    1 -
>  arch/arc/kernel/setup.c                     |    2 +-
>  arch/metag/kernel/setup.c                   |    6 +-----
>  arch/mips/include/asm/mips-boards/generic.h |    4 ----
>  arch/mips/lantiq/prom.h                     |    2 --
>  arch/mips/netlogic/xlp/dt.c                 |    4 ++--
>  arch/mips/ralink/of.c                       |    2 --
>  arch/openrisc/kernel/setup.c                |    2 +-
>  arch/openrisc/kernel/vmlinux.h              |    2 --
>  arch/xtensa/kernel/setup.c                  |    3 +--
>  include/linux/of_fdt.h                      |    3 +++
>  11 files changed, 9 insertions(+), 22 deletions(-)


Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
