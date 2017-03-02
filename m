Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36712 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdCBI1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 03:27:36 -0500
Date: Thu, 2 Mar 2017 09:01:26 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 05/14] x86: Use set_memory.h header
Message-ID: <20170302080126.GA9574@gmail.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-6-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-6-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170302080126.5uZI46YWW_r51xAVMI5RI74P-_ypWc3vv4S5kKHsl-E@z>


* Laura Abbott <labbott@redhat.com> wrote:

> 
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/x86/kernel/amd_gart_64.c      | 2 +-
>  arch/x86/kernel/cpu/amd.c          | 2 +-
>  arch/x86/kernel/cpu/bugs.c         | 2 +-
>  arch/x86/kernel/ftrace.c           | 2 +-
>  arch/x86/kernel/machine_kexec_64.c | 1 +
>  arch/x86/mm/init.c                 | 2 +-
>  arch/x86/mm/init_64.c              | 2 +-
>  arch/x86/mm/ioremap.c              | 2 +-
>  arch/x86/mm/pageattr.c             | 1 +
>  arch/x86/net/bpf_jit_comp.c        | 1 +
>  arch/x86/pci/pcbios.c              | 2 +-
>  arch/x86/platform/efi/efi.c        | 2 +-
>  arch/x86/realmode/init.c           | 2 +-
>  13 files changed, 13 insertions(+), 10 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
