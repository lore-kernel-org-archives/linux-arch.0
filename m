Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:43803 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0FNSWg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2010 14:22:36 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 851248272
	for <linux-arch@vger.kernel.org>; Mon, 14 Jun 2010 20:22:35 +0200 (CEST)
Date: Mon, 14 Jun 2010 20:22:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/5] vmlinux.lds.h: Include *(.text.*) in TEXT_TEXT
Message-ID: <20100614182212.GA14747@merkur.ravnborg.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tim Abbott <tabbott@ksplice.com>, linux-kernel@vger.kernel.org
Message-ID: <20100614182212.0mqrKp6UDWGxoiepdIJLXpKMieS6TBoYxkIIVuOVIeg@z>

On Mon, Jun 14, 2010 at 01:38:28PM +0100, Matt Fleming wrote:
> From: Matt Fleming <matthew.fleming@imgtec.com>
> 
> Many architectures collect text sections beginning with '.text.' in
> their .text section, so move this pattern into TEXT_TEXT to stop them
> all having to duplicate the pattern in their arch/ linker scripts.
> 
> Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
> ---
>  include/asm-generic/vmlinux.lds.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 48c5299..08f4680 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -369,6 +369,7 @@
>  		ALIGN_FUNCTION();					\
>  		*(.text.hot)						\
>  		*(.text)						\
> +		*(.text.*)						\
>  		*(.ref.text)						\
>  	DEV_KEEP(init.text)						\
>  	DEV_KEEP(exit.text)						\

This will break ia64.
From their vmlinux.lds.h:

        TEXT_TEXT
        SCHED_TEXT
        LOCK_TEXT
        KPROBES_TEXT
        *(.gnu.linkonce.t*)
    }
  .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
        { *(.text2) }
#ifdef CONFIG_SMP
  .text..lock : AT(ADDR(.text..lock) - LOAD_OFFSET)
        { *(.text..lock) }
#endif

The patch above we would match the section ".text.*" too soon and
add the .text..lock section at the wrong place.

Browsing the vmlinux.lds files other archs will be impacted too.

If you feel tempted to clean up the linker script one place to start
would be to introduce consistent indention / layout.
If you use arch/sparc/kernel/vmlinux.lds.h as a template then you
have a good start.

The above mentioned ia64 vmlinux.lds.h would be a good place to start.

	Sam
