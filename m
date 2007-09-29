Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dike.telenet-ops.be ([195.130.132.36]:49190 "EHLO
	dike.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527AbXI2KkG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2007 06:40:06 -0400
Received: from europa.telenet-ops.be (europa.telenet-ops.be [195.130.137.75])
	by dike.telenet-ops.be (Postfix) with ESMTP id 1F331823B3E
	for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2007 11:12:08 +0200 (CEST)
Date: Sat, 29 Sep 2007 11:11:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Generic compat_sys_fallocate
In-Reply-To: <1191018832-18069-2-git-send-email-kyle@mcmartin.ca>
Message-ID: <Pine.LNX.4.64.0709291109320.10965@anakin>
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca>
 <1191018832-18069-2-git-send-email-kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 28 Sep 2007, Kyle McMartin wrote:
> --- a/fs/compat.c
> +++ b/fs/compat.c
> @@ -2226,3 +2226,13 @@ asmlinkage long compat_sys_timerfd(int ufd, int clockid, int flags,
>  }
>  
>  #endif /* CONFIG_TIMERFD */
> +
> +asmlinkage long compat_sys_fallocate(int fd, int mode,
> +				     u32 offset_lo, u32 offset_hi,
> +				     u32 len_lo, u32 len_hi)
> +{
> +	u64 offset = compat_merge64(offset_lo, offset_hi);
> +	u64 len = compat_merge64(len_lo, len_hi);
> +
> +	return sys_fallocate(fd, mode, offset, len);
> +}

To avoid confusion, you may want to rename the *_{lo,hi} parameters to
e.g. *_{l,r}, as they don't actually mean the low and high part anymore.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
