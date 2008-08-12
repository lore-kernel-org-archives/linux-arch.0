From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 179/322] flag parameters add-on: remove epoll_create size
 param
Date: Tue, 12 Aug 2008 08:51:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808120849440.11658@anakin>
References: <200807240429.m6O4ThGR029384@imap1.linux-foundation.org>
 <Pine.LNX.4.64.0808101411490.10672@anakin> <20080811170036.a44a26f5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:33187 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYHLGwa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Aug 2008 02:52:30 -0400
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 698375893CB
	for <linux-arch@vger.kernel.org>; Tue, 12 Aug 2008 08:52:29 +0200 (CEST)
In-Reply-To: <20080811170036.a44a26f5.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: drepper@redhat.com, torvalds@linux-foundation.org, davidel@xmailserver.org, linux-arch@vger.kernel.org, mtk.manpages@googlemail.com

On Mon, 11 Aug 2008, Andrew Morton wrote:
> On Sun, 10 Aug 2008 14:13:32 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 23 Jul 2008, akpm@linux-foundation.org wrote:
> > > Remove the size parameter from the new epoll_create syscall and renames the
> > > syscall itself.  The updated test program follows.
> > > 
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > #include <fcntl.h>
> > > #include <stdio.h>
> > > #include <time.h>
> > > #include <unistd.h>
> > > #include <sys/syscall.h>
> > > 
> > > #ifndef __NR_epoll_create2
> > 			   ^
> > The test program still uses __NR_epoll_create2 instead of
> > __NR_epoll_create1 everywhere.
> 
> Which test program is that?

The corresponding test program for the sys_epoll_create1() system call, as
present in the commit comments:

commit 9fe5ad9c8cef9ad5873d8ee55d1cf00d9b607df0
Author: Ulrich Drepper <drepper@redhat.com>
Date:   Wed Jul 23 21:29:43 2008 -0700

    flag parameters add-on: remove epoll_create size param
    
    Remove the size parameter from the new epoll_create syscall and renames the
    syscall itself.  The updated test program follows.

    [ test program ]

> > > diff -puN fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param fs/eventpoll.c
> > > --- a/fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param
> > > +++ a/fs/eventpoll.c
> > > @@ -1046,7 +1046,7 @@ retry:
> > >   * RB tree. With the current implementation, the "size" parameter is ignored
> >                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   * (besides sanity checks).
> >       ^^^^^^^^^^^^^^^^^^^^^^^
> > >   */
> > > -asmlinkage long sys_epoll_create2(int size, int flags)
> > > +asmlinkage long sys_epoll_create1(int flags)
> > 
> > The function comment was not updated for the removal of the `size'
> > parameter. Can you please fix that?
> 
> I did this:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> The `size' argument was removed.
> 
> Reported-by:  Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ulrich Drepper <drepper@redhat.com>
> Cc: Davide Libenzi <davidel@xmailserver.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/eventpoll.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff -puN fs/eventpoll.c~fs-eventpollc-fix-sys_epoll_create1-comment fs/eventpoll.c
> --- a/fs/eventpoll.c~fs-eventpollc-fix-sys_epoll_create1-comment
> +++ a/fs/eventpoll.c
> @@ -1041,10 +1041,7 @@ retry:
>  }
>  
>  /*
> - * It opens an eventpoll file descriptor. The "size" parameter is there
> - * for historical reasons, when epoll was using an hash instead of an
> - * RB tree. With the current implementation, the "size" parameter is ignored
> - * (besides sanity checks).
> + * Open an eventpoll file descriptor.
>   */
>  asmlinkage long sys_epoll_create1(int flags)
>  {
> _
> 

Looks fine. Thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
