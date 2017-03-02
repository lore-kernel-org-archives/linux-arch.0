Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37606 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbdCBOwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 09:52:45 -0500
Subject: Re: [PATCHv2 09/14] watchdog: hpwdt: Use set_memory.h header
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-10-git-send-email-labbott@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e99102e0-ae16-9720-a541-75e09bc0b68d@roeck-us.net>
Date: Thu, 2 Mar 2017 06:48:34 -0800
MIME-Version: 1.0
In-Reply-To: <1488413706-9739-10-git-send-email-labbott@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>, Wim Van Sebroeck <wim@iguana.be>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170302144834.FtQpWfYRd82WMsWgXCIqDNjxXG8FywycvQpFpEeqjZM@z>

On 03/01/2017 04:15 PM, Laura Abbott wrote:
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 70c7194..67fbe35 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -34,7 +34,7 @@
>  #include <linux/nmi.h>
>  #include <linux/kdebug.h>
>  #include <linux/notifier.h>
> -#include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  #endif /* CONFIG_HPWDT_NMI_DECODING */
>  #include <asm/nmi.h>
>  #include <asm/frame.h>
>
