Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbdCBOTT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Mar 2017 09:19:19 -0500
Date: Thu, 2 Mar 2017 14:12:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
Message-ID: <20170302141251.GM19632@leverpostej>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170302141252.-kli6hgeXqeIwmWBD1gCB7tdkQ2H9tY7SR_Qz3OZcjk@z>

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> 
> Now that all call sites, completely decouple cacheflush.h and
> set_memory.h
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm/include/asm/cacheflush.h   | 1 -
>  arch/arm64/include/asm/cacheflush.h | 1 -
>  arch/s390/include/asm/Kbuild        | 1 +
>  arch/s390/include/asm/cacheflush.h  | 8 --------
>  arch/x86/include/asm/cacheflush.h   | 1 -
>  5 files changed, 1 insertion(+), 11 deletions(-)
>  delete mode 100644 arch/s390/include/asm/cacheflush.h
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 1cb9d11..d69bebf 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,7 +16,6 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> -#include <asm/set_memory.h>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
