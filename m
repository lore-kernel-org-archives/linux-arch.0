From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Thu, 20 Oct 2016 15:33:27 +0100
Message-ID: <20161020143327.GY1041@n2100.armlinux.org.uk>
References: <20161017065131.GA27863@angband.pl>
 <6556201.qTG4Pa4aHk@wuerfel>
 <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
 <3114442.xCAy34UQCk@wuerfel>
 <20161019153159.GQ1041@n2100.armlinux.org.uk>
 <20161020150814.42951f61@roar.ozlabs.ibm.com>
 <20161020131702.GX1041@n2100.armlinux.org.uk>
 <20161021012017.67b75a90@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161021012017.67b75a90@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 21, 2016 at 01:20:17AM +1100, Nicholas Piggin wrote:
> Good catch, I'm surprised you're the first one who reported it. This patch
> seems to do the trick for me:

And me, thanks, so...

> 
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Fri, 21 Oct 2016 01:13:33 +1100
> Subject: [PATCH] kbuild: prevent lib-ksyms.o rebuilds
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

> 
> ---
>  scripts/Makefile.build | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index de46ab0..e1f25d6 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -430,6 +430,9 @@ cmd_export_list = $(OBJDUMP) -h $< | \
>  
>  $(obj)/lib-ksyms.o: $(lib-target) FORCE
>  	$(call if_changed,export_list)
> +
> +targets += $(obj)/lib-ksyms.o
> +
>  endif
>  
>  #

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
