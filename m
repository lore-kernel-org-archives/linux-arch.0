From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 179/322] flag parameters add-on: remove epoll_create
 size param
Date: Mon, 11 Aug 2008 17:00:36 -0700
Message-ID: <20080811170036.a44a26f5.akpm@linux-foundation.org>
References: <200807240429.m6O4ThGR029384@imap1.linux-foundation.org>
	<Pine.LNX.4.64.0808101411490.10672@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36477 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbYHLABY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Aug 2008 20:01:24 -0400
In-Reply-To: <Pine.LNX.4.64.0808101411490.10672@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: drepper@redhat.com, torvalds@linux-foundation.org, davidel@xmailserver.org, linux-arch@vger.kernel.org, mtk.manpages@googlemail.com

On Sun, 10 Aug 2008 14:13:32 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, 23 Jul 2008, akpm@linux-foundation.org wrote:
> > Remove the size parameter from the new epoll_create syscall and renames the
> > syscall itself.  The updated test program follows.
> > 
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <time.h>
> > #include <unistd.h>
> > #include <sys/syscall.h>
> > 
> > #ifndef __NR_epoll_create2
> 			   ^
> The test program still uses __NR_epoll_create2 instead of
> __NR_epoll_create1 everywhere.

Which test program is that?

> > diff -puN fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param fs/eventpoll.c
> > --- a/fs/eventpoll.c~flag-parameters-add-on-remove-epoll_create-size-param
> > +++ a/fs/eventpoll.c
> > @@ -1046,7 +1046,7 @@ retry:
> >   * RB tree. With the current implementation, the "size" parameter is ignored
>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   * (besides sanity checks).
>       ^^^^^^^^^^^^^^^^^^^^^^^
> >   */
> > -asmlinkage long sys_epoll_create2(int size, int flags)
> > +asmlinkage long sys_epoll_create1(int flags)
> 
> The function comment was not updated for the removal of the `size'
> parameter. Can you please fix that?

I did this:

From: Andrew Morton <akpm@linux-foundation.org>

The `size' argument was removed.

Reported-by:  Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/eventpoll.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -puN fs/eventpoll.c~fs-eventpollc-fix-sys_epoll_create1-comment fs/eventpoll.c
--- a/fs/eventpoll.c~fs-eventpollc-fix-sys_epoll_create1-comment
+++ a/fs/eventpoll.c
@@ -1041,10 +1041,7 @@ retry:
 }
 
 /*
- * It opens an eventpoll file descriptor. The "size" parameter is there
- * for historical reasons, when epoll was using an hash instead of an
- * RB tree. With the current implementation, the "size" parameter is ignored
- * (besides sanity checks).
+ * Open an eventpoll file descriptor.
  */
 asmlinkage long sys_epoll_create1(int flags)
 {
_
