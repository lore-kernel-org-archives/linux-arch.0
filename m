From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 6/9] RISC-V: Device, timer, IRQs, and the SBI
Date: Thu, 29 Jun 2017 10:39:25 +0200
Message-ID: <20170629083924.GB5851@distanz.ch>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-7-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:38528 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbdF2Ijg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 04:39:36 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-7-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On 2017-06-28 at 20:55:35 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
[...]
> diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
> new file mode 100644
> index 000000000000..28975e528d2f
> --- /dev/null
> +++ b/arch/riscv/include/asm/device.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2016 SiFive
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +
> +#ifndef _ASM_RISCV_DEVICE_H
> +#define _ASM_RISCV_DEVICE_H
> +
> +#include <linux/sysfs.h>
> +
> +struct dev_archdata {
> +	struct dma_map_ops *dma_ops;
> +};

The dma_ops member isn't used in any arch code or driver from what I can
tell (I checked against your riscv-for-submission-v3 branch). Could
device.h from asm-generic be used instead, or did I miss something?

> +
> +struct pdev_archdata {
> +};
> +
> +#endif /* _ASM_RISCV_DEVICE_H */
