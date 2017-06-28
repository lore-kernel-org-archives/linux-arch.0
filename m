From: Karsten Merker <merker@debian.org>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Wed, 28 Jun 2017 23:05:14 +0200
Message-ID: <20170628210513.iao6g7mvobe4jlqy@excalibur.cnev.de>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-10-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:65036 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdF1VGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 17:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-10-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
> This patch contains all the build infastructure that actually enables
> the RISC-V port.  This includes Makefiles, linker scripts, and Kconfig
> files.  It also contains the only top-level change, which adds RISC-V to
> the list of architectures that need a sed run to produce the ARCH
> variable when building locally.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
[...]
> diff --git a/arch/riscv/configs/freedom-u500_defconfig b/arch/riscv/configs/freedom-u500_defconfig
> new file mode 100644
> index 000000000000..b37908d45067
> --- /dev/null
> +++ b/arch/riscv/configs/freedom-u500_defconfig
> @@ -0,0 +1,53 @@
> +CONFIG_CROSS_COMPILE="riscv64-unknown-linux-gnu-"

Hello Palmer,

just a tiny nitpick: defconfigs shouldn't predefine a crosscompiler
prefix.  That has already been fixed in the other defconfigs at
some earlier point in time, but IIRC the freedom-u500_defconfig got
added later on and it was probably overlooked then.

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
