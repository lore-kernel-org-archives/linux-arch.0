From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] move BUG_TABLE into RODATA
Date: Tue, 22 Apr 2008 20:07:32 +0200
Message-ID: <20080422180732.GA27222@uranus.ravnborg.org>
References: <480E1BEE.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <480E1BEE.76E4.0078.0-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <jbeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Jan.

> --- linux-2.6.25/arch/x86/kernel/vmlinux_64.lds.S	2008-04-17 04:49:44.000000000 +0200
> +++ 2.6.25-bug-table-rodata/arch/x86/kernel/vmlinux_64.lds.S	2008-03-04 11:14:13.000000000 +0100
> @@ -19,7 +19,7 @@ PHDRS {
>  	data PT_LOAD FLAGS(7);	/* RWE */
>  	user PT_LOAD FLAGS(7);	/* RWE */
>  	data.init PT_LOAD FLAGS(7);	/* RWE */
> -	note PT_NOTE FLAGS(4);	/* R__ */
> +	note PT_NOTE FLAGS(0);	/* ___ */
>  }

Is this intentional in this patch?


>  SECTIONS
>  {
> @@ -40,16 +40,14 @@ SECTIONS
>  	_etext = .;		/* End of text section */
>    } :text = 0x9090
>  
> +  NOTES :text :note
> +
>    . = ALIGN(16);		/* Exception table */
>    __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>    	__start___ex_table = .;
>  	 *(__ex_table)
>    	__stop___ex_table = .;
> -  }
> -
> -  NOTES :text :note
> -
> -  BUG_TABLE :text
> +  } :text = 0x9090

And I do not see the 0x9090 justified.
Is this something to do with the fact that 0x90 equals NOP on x86?

Rest looks good.

	Sam
