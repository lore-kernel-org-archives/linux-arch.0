Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:63975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759739AbcILPAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 11:00:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Build failures in -next: sys_pkey_mprotect etc. undefined
Date: Mon, 12 Sep 2016 16:59:30 +0200
Message-ID: <9369809.1DWhqOZ7mo@wuerfel>
In-Reply-To: <9d74497b-1522-b350-42fa-49df2df48c4a@roeck-us.net>
References: <9d74497b-1522-b350-42fa-49df2df48c4a@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:ABI/API" <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160912145930.gz04m_kds7Xp3_L0oUPzRoJzEijSwIuZ6aAnjGQqFAU@z>

On Monday, September 12, 2016 7:55:33 AM CEST Guenter Roeck wrote:
> Building h8300:allnoconfig ... failed
> Building h8300:h8300h-sim_defconfig ... failed
> Building c6x:dsk6455_defconfig ... failed
> 
> [ and more builds for the same architectures ]
> 
> --------------
> Error log:
> arch/h8300/kernel/built-in.o:(.data+0x480): undefined reference to `sys_pkey_mprotect'
> arch/h8300/kernel/built-in.o:(.data+0x484): undefined reference to `sys_pkey_alloc'
> arch/h8300/kernel/built-in.o:(.data+0x488): undefined reference to `sys_pkey_free'
> 
> Other architectures (frv, xtensa, score) currently fail to build for other reasons,
> so I don't really know if the above are the only ones affected.
> 
> 

I think the best solution would be to add them to kernel/sys_ni.c so we can
assign syscall numbers for all architectures regardless of whether they use it
or not (most of them will never use these AFAICT).

	Arnd

