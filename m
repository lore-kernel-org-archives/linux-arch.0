Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59404 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbdLHPFM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 10:05:12 -0500
Date: Fri, 8 Dec 2017 15:05:06 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v3 05/33] nds32: Exception handling
Message-ID: <20171208150506.GL21978@ZenIV.linux.org.uk>
References: <cover.1512723245.git.green.hu@gmail.com>
 <8fad3e13c85cd90bd038cac7ead0e97e4438a0e0.1512723245.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fad3e13c85cd90bd038cac7ead0e97e4438a0e0.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171208150506.YQ3Qlt_zd4az0JIzy8eJlhlEAY7y1FZL0lp4-Boi2OU@z>

On Fri, Dec 08, 2017 at 05:11:48PM +0800, Greentime Hu wrote:

> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> new file mode 100644
> index 0000000..30a275d
> --- /dev/null
> +++ b/arch/nds32/kernel/traps.c
> @@ -0,0 +1,441 @@
> +/*
> + * Copyright (C) 2005-2017 Andes Technology Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/personality.h>
> +#include <linux/kallsyms.h>
> +#include <linux/hardirq.h>
> +#include <linux/kdebug.h>
> +#include <linux/sched/task_stack.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/uaccess.h>

The only include of asm/uaccess.h should be in linux/uaccess.h; everything
else should include linux/uaccess.h.  The same goes for other patches in
the series.
