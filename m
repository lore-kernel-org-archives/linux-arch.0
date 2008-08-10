From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 179/322] flag parameters add-on: remove epoll_create size
 param
Date: Sun, 10 Aug 2008 14:13:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808101411490.10672@anakin>
References: <200807240429.m6O4ThGR029384@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wilson.telenet-ops.be ([195.130.132.42]:49538 "EHLO
	wilson.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbYHJMNg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Aug 2008 08:13:36 -0400
In-Reply-To: <200807240429.m6O4ThGR029384@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, davidel@xmailserver.org, linux-arch@vger.kernel.org, mtk.manpages@googlemail.com

On Wed, 23 Jul 2008, akpm@linux-foundation.org wrote:
> Remove the size parameter from the new epoll_create syscall and renames the
> syscall itself.  The updated test program follows.
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> #include <fcntl.h>
> #include <stdio.h>
> #include <time.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> 
> #ifndef __NR_epoll_create2
			   ^
The test program still uses __NR_epoll_create2 instead of
__NR_epoll_create1 everywhere.

> diff -puN fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param fs/eventpoll.c
> --- a/fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param
> +++ a/fs/eventpoll.c
> @@ -1046,7 +1046,7 @@ retry:
>   * RB tree. With the current implementation, the "size" parameter is ignored
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   * (besides sanity checks).
      ^^^^^^^^^^^^^^^^^^^^^^^
>   */
> -asmlinkage long sys_epoll_create2(int size, int flags)
> +asmlinkage long sys_epoll_create1(int flags)

The function comment was not updated for the removal of the `size'
parameter. Can you please fix that?

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
