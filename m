Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Mar 2005 00:24:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Double free of initramfs
Message-ID: <20050322232402.GA16597@mars.ravnborg.org>
References: <20050316184932.GB16712@linux-mips.org> <20050321182146.32a20ebf.akpm@osdl.org> <20050322224117.GH31706@linux-mips.org> <20050322225725.GB10549@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322225725.GB10549@mars.ravnborg.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 22, 2005 at 11:57:25PM +0100, Sam Ravnborg wrote:
> Something like this:
> 
> ===== include/asm-generic/vmlinux.lds.h 1.18 vs edited =====
> --- 1.18/include/asm-generic/vmlinux.lds.h	2005-03-14 20:55:39 +01:00
> +++ edited/include/asm-generic/vmlinux.lds.h	2005-03-22 23:55:17 +01:00
> @@ -97,3 +97,12 @@
>  		VMLINUX_SYMBOL(__lock_text_start) = .;			\
>  		*(.spinlock.text)					\
>  		VMLINUX_SYMBOL(__lock_text_end) = .;
> +
> +/* initramfs area. */
> +# define INITRAMFS							\
> +	. = ALIGN(4096);						\

Based on Tony's very valid comment this should read:
> +	. = ALIGN(PAGE_SIZE);						\
(Assuming the 4096 was a page alingment).

	Sam
