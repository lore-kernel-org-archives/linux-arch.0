From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 05/29] nios2: Memory management
Date: Wed, 30 Jul 2014 11:01:02 +0200
Message-ID: <20140730090101.GD10301@distanz.ch>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
 <1405413956-2772-6-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405413956-2772-6-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On 2014-07-15 at 10:45:32 +0200, Ley Foon Tan <lftan@altera.com> wrote:
> This patch contains the initialisation of the memory blocks, MMU
> attributes and the memory map.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  arch/nios2/include/asm/mmu.h     |  18 +++
>  arch/nios2/include/asm/page.h    | 113 +++++++++++++++++++
>  arch/nios2/include/asm/uaccess.h | 233 +++++++++++++++++++++++++++++++++++++++
>  arch/nios2/mm/init.c             | 142 ++++++++++++++++++++++++
>  arch/nios2/mm/uaccess.c          | 162 +++++++++++++++++++++++++++
>  5 files changed, 668 insertions(+)
>  create mode 100644 arch/nios2/include/asm/mmu.h
>  create mode 100644 arch/nios2/include/asm/page.h
>  create mode 100644 arch/nios2/include/asm/uaccess.h
>  create mode 100644 arch/nios2/mm/init.c
>  create mode 100644 arch/nios2/mm/uaccess.c

[...]

> diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
> new file mode 100644
> index 0000000..b89c1d6
> --- /dev/null
> +++ b/arch/nios2/include/asm/page.h
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
> + * Copyright (C) 2004 Microtronix Datacom Ltd.
> + *
> + * MMU support based on asm/page.h from mips which is:
> + *
> + * Copyright (C) 1994 - 1999, 2000, 03 Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + *
> + * NOMMU support based on asm/page.h from m68knommu.

You might want to remove this line to avoid confusion, since NOMMU is
not supported anymore in this submission of the NIOS II port.

> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
