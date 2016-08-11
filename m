From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [EXPERIMENTAL] enable thin archives and --gc-sections on ARM
Date: Thu, 11 Aug 2016 16:01:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1608111536290.17623@knanqh.ubzr>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com> <3116731.ej669o70yG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <3116731.ej669o70yG@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 11 Aug 2016, Arnd Bergmann wrote:

> This goes on top of Nick's latest version of "[PATCH 0/6 v2] kbuild changes,
> thin archives, --gc-sections" and enables both features on ARM.
> 
[...]
> 
> - I mark a ton of sections as KEEP() in vmlinux.lds.S. Some of
>   them might not actually be needed, and I have not spent much
>   time checking what they actually are. However, I did build
>   a few hundred randconfigs without new issues.
> 
> index 7396a5f00c5f..61b9b8784036 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -17,7 +17,7 @@
>  #define PROC_INFO							\
>  	. = ALIGN(4);							\
>  	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
> -	*(.proc.info.init)						\
> +	KEEP(*(.proc.info.init))					\

OK.

>  	VMLINUX_SYMBOL(__proc_info_end) = .;
>  
>  #define HYPERVISOR_TEXT							\
> @@ -104,7 +104,7 @@ SECTIONS
>  		_stext = .;		/* Text and read-only data	*/
>  			IDMAP_TEXT
>  			__exception_text_start = .;
> -			*(.exception.text)
> +			KEEP(*(.exception.text))

No need here. The code there has to be referenced from somewhere. If not 
it should not be kept.

>  			__exception_text_end = .;
>  			IRQENTRY_TEXT
>  			SOFTIRQENTRY_TEXT
> @@ -169,14 +169,14 @@ SECTIONS
>  	 */
>  	__vectors_start = .;
>  	.vectors 0xffff0000 : AT(__vectors_start) {
> -		*(.vectors)
> +		KEEP(*(.vectors))

OK.

>  	}
>  	. = __vectors_start + SIZEOF(.vectors);
>  	__vectors_end = .;
>  
>  	__stubs_start = .;
>  	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
> -		*(.stubs)
> +		KEEP(*(.stubs))

This is referenced from .vectors entries and therefore the KEEP() is not 
needed.  There is nothing to be saved either ways though.

>  	}
>  	. = __stubs_start + SIZEOF(.stubs);
>  	__stubs_end = .;
> @@ -192,24 +192,24 @@ SECTIONS
>  	}
>  	.init.arch.info : {
>  		__arch_info_begin = .;
> -		*(.arch.info.init)
> +		KEEP(*(.arch.info.init))

OK.

>  		__arch_info_end = .;
>  	}
>  	.init.tagtable : {
>  		__tagtable_begin = .;
> -		*(.taglist.init)
> +		KEEP(*(.taglist.init))

OK.

>  		__tagtable_end = .;
>  	}
>  #ifdef CONFIG_SMP_ON_UP
>  	.init.smpalt : {
>  		__smpalt_begin = .;
> -		*(.alt.smp.init)
> +		KEEP(*(.alt.smp.init))

Yes unfortunately this needs a KEEP() right now as there is no explicit 
references to those entries. But by doing so you force a reference from 
those entries to all functions they annotate, preventing those functions 
from being discarded if there isn't any reference to that code 
otherwise. That's a case that falls into the "missing forward reference" 
category in my slides.

>  		__smpalt_end = .;
>  	}
>  #endif
>  	.init.pv_table : {
>  		__pv_table_begin = .;
> -		*(.pv_table)
> +		KEEP(*(.pv_table))

Ditto here.


Nicolas
