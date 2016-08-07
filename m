Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36791 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcHGXtx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 19:49:53 -0400
Date: Mon, 8 Aug 2016 09:19:47 +0930
From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160807234947.GV20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-3-git-send-email-npiggin@gmail.com>
 <20160807095739.GU20904@bubble.grove.modra.org>
 <12986071.MeSB5hmlsH@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12986071.MeSB5hmlsH@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org
Message-ID: <20160807234947.bf1k_MNsEKb-0cBt8DgHpRcbWXuWinmAHAAX71XpjA4@z>

On Sun, Aug 07, 2016 at 10:26:19PM +0200, Arnd Bergmann wrote:
> On Sunday, August 7, 2016 7:27:39 PM CEST Alan Modra wrote:
> > 
> > If it can, then Nicholas' patch should be:
> > 
> >         *(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)
> > 
> > If you can't put .text.fixup too far away then you may as well just use
> > 
> >         *(.text .text.*)
> 
> I tried this version:
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b1f8828e9eac..fc210dacac9a 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -438,7 +438,9 @@
>   * during second ld run in second ld pass when generating System.map */
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
> -		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
> +		*(.text.hot .text.hot.*)				\
> +		*(.text.unlikely .text.fixup .text.unlikely.*)		\
> +		*(.text .text.*)					\
>  		*(.ref.text)						\
>  	MEM_KEEP(init.text)						\
>  	MEM_KEEP(exit.text)						\
> 
> but that failed to link an allyesconfig kernel because of references
> from .fixup to .text.*. Trying your version now:

Well then, that proves you can't put .text.fixup too far aways from
the associated input section.

> *(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)

Which means this is guaranteed to fail when you test it properly using
gcc's profiling options, in order to generate .text.hot* and/or
.text.unlikely* sections.

It seems to me the right thing to do would be to change kernel asm to
generate .text.foo.fixup for any .text.foo section.  A gas feature
available with binutils-2.26 enabled by --sectname-subst might help
with implementing that.

-- 
Alan Modra
Australia Development Lab, IBM
