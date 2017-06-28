From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Wed, 28 Jun 2017 14:13:00 -0700 (PDT)
Message-ID: <mhng-b3676d94-34ef-4e17-abd0-326670f1318e@palmer-si-x1c4>
References: <20170628210513.iao6g7mvobe4jlqy@excalibur.cnev.de>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34952 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdF1VNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 17:13:02 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so9441661pgc.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Jun 2017 14:13:02 -0700 (PDT)
In-Reply-To: <20170628210513.iao6g7mvobe4jlqy@excalibur.cnev.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: merker@debian.org
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 14:05:14 PDT (-0700), merker@debian.org wrote:
> On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
>> This patch contains all the build infastructure that actually enables
>> the RISC-V port.  This includes Makefiles, linker scripts, and Kconfig
>> files.  It also contains the only top-level change, which adds RISC-V to
>> the list of architectures that need a sed run to produce the ARCH
>> variable when building locally.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
> [...]
>> diff --git a/arch/riscv/configs/freedom-u500_defconfig b/arch/riscv/configs/freedom-u500_defconfig
>> new file mode 100644
>> index 000000000000..b37908d45067
>> --- /dev/null
>> +++ b/arch/riscv/configs/freedom-u500_defconfig
>> @@ -0,0 +1,53 @@
>> +CONFIG_CROSS_COMPILE="riscv64-unknown-linux-gnu-"
>
> just a tiny nitpick: defconfigs shouldn't predefine a crosscompiler
> prefix.  That has already been fixed in the other defconfigs at
> some earlier point in time, but IIRC the freedom-u500_defconfig got
> added later on and it was probably overlooked then.

Oh, sorry about that -- you're right, I just missed that one as it wasn't in
the original patch set.

I'll squash this in when we do a v4.

commit 1a262894827be647d55016da09f61eb49962dd7d
Author: Palmer Dabbelt <palmer@dabbelt.com>
Date:   Wed Jun 28 14:11:17 2017 -0700

    Don't define CROSS_COMPILE in the u500 defconfig

diff --git a/arch/riscv/configs/freedom-u500_defconfig b/arch/riscv/configs/freedom-u500_defconfig
index b37908d45067..b580dc5c8feb 100644
--- a/arch/riscv/configs/freedom-u500_defconfig
+++ b/arch/riscv/configs/freedom-u500_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="riscv64-unknown-linux-gnu-"
 CONFIG_DEFAULT_HOSTNAME="ucbvax"
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 # CONFIG_FHANDLE is not set
