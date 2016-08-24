From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] kbuild: add arch specific post-link Makefile
Date: Wed, 24 Aug 2016 23:32:08 +1000
Message-ID: <20160824233208.1b068a89@roar.ozlabs.ibm.com>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
        <1472041761-14414-4-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36350 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbcHXNck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 09:32:40 -0400
In-Reply-To: <1472041761-14414-4-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Wed, 24 Aug 2016 22:29:21 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Allow architectures to create arch/xxx/Makefile.postlink with targets
> for vmlinux, modules.ko, and clean, which will be invoked after final
> linking of vmlinux and modules.
> 
> powerpc will use this to check vmlinux linker relocations for sanity,
> and may use it to fix up alternate instruction patch branch addresses.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


> diff --git a/arch/Kconfig b/arch/Kconfig
> index 94138e5..c8a1677 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -424,6 +424,13 @@ config CC_STACKPROTECTOR_STRONG
>  
>  endchoice
>  
> +config BUILD_ARCH_POSTLINK
> +	bool
> +	help
> +	  Select this if the architecture wants to have a Makefile invoked
> +	  on modules and vmlinux after they are linked. The architecture
> +	  must provide arch/?/Makefile.postlink
> +
>  config THIN_ARCHIVES
>  	bool
>  	help

Argh! Sorry, this thing crept back in again. No other reference to
BUILD_ARCH_POSTLINK in the patch, so it won't invalidate testing
to just remove the hunk.

Thanks,
Nick
