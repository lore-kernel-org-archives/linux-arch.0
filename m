Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:48794 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262090AbUCaLjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2004 06:39:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: generalize/fix wchan calculation via ELF sections
Date: Wed, 31 Mar 2004 13:30:11 +0200
References: <20040331073539.GX791@holomorphy.com>
In-Reply-To: <20040331073539.GX791@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403311330.12089.arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 31 March 2004 09:35, William Lee Irwin III wrote:

> Basically, I'm looking to see if I flubbed the patch and may not have
> swept all arches properly, or whether arch maintainers dislike whatever
> aspects of it since it goes poking around their code. Whatever kind of
> feedback may be relevant wrt. methods/cleanliness/etc. is also good.

> Index: sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S
> ===================================================================
> --- sched-2.6.5-rc3.orig/arch/i386/kernel/vmlinux.lds.S 2004-03-29 19:25:34.000000000 -0800
> +++ sched-2.6.5-rc3/arch/i386/kernel/vmlinux.lds.S      2004-03-30 23:25:36.000000000 -0800
> @@ -16,6 +16,9 @@
>    _text = .;                   /* Text and read-only data */
>    .text : {
>         *(.text)
> +       __scheduling_functions_start_here = .;
> +       *(.sched.text)
> +       __scheduling_functions_end_here = .;
>         *(.fixup)
>         *(.gnu.warning)
>         } = 0x9090

No objections, just an idea: It might be good to put the vmlinux.lds.S
changes into a macro in include/asm-generic/vmlinux.lds.h. IIRC, that's
what that file was introduced for, although it's not used for many things
so far.

	Arnd <><
