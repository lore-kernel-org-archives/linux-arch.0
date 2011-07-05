From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 2/2] modules: make arch's use default loader hooks
Date: Tue, 05 Jul 2011 13:25:05 +0200
Message-ID: <4E12F491.4070906@monstr.eu>
References: <201106281245.19457.arnd@arndb.de> <1309461732-2875-1-git-send-email-jonas@southpole.se> <1309461732-2875-2-git-send-email-jonas@southpole.se>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309461732-2875-2-git-send-email-jonas@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>
Cc: rusty@rustcorp.com.au, arnd@ardnb.de, geert@linux-m68k.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, cmetcalf@tilera.com, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Jonas Bonn wrote:
> This patch removes all the module loader hook implementations in the
> architecture specific code where the functionality is the same as that
> now provided by the recently added default hooks.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> ---
>  arch/alpha/kernel/module.c      |   34 ---------------------
>  arch/arm/kernel/module.c        |   29 +------------------
>  arch/avr32/kernel/module.c      |   20 -------------
>  arch/blackfin/kernel/module.c   |   21 -------------
>  arch/cris/kernel/module.c       |   43 ++-------------------------
>  arch/frv/kernel/module.c        |   57 ++----------------------------------
>  arch/h8300/kernel/module.c      |   45 ----------------------------
>  arch/ia64/kernel/module.c       |   16 ----------
>  arch/m32r/kernel/module.c       |   38 ------------------------
>  arch/m68k/kernel/module_mm.c    |   27 -----------------
>  arch/m68k/kernel/module_no.c    |   34 ---------------------
>  arch/microblaze/kernel/module.c |   35 ----------------------

I tested it on Microblaze.

Tested-by: Michal Simek <monstr@monstr.eu>

Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
