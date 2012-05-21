From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Arch maintainers Ahoy! (was Re: x86: faster strncpy_from_user())
Date: Mon, 21 May 2012 09:50:34 -0700
Message-ID: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47151 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2EUQu4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 May 2012 12:50:56 -0400
Received: by weyu7 with SMTP id u7so3315984wey.19
        for <linux-arch@vger.kernel.org>; Mon, 21 May 2012 09:50:55 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Ok, several weeks ago I sent out an email about the x86
strncpy_from_user() patch I did, and cc'd linux-arch because the
second stage might well affect other architectures.

Nobody reacted to it, and today that second stage was merged into
mainline, so I thought I'd re-do the notice. The relevant part of the
original explanation is appended, but I'll explain once more..

On x86, we *used* to be very lazy about strncpy_from_user(), and not
actually do the full proper error handling: the code was (for
historical reasons) using inline asms where it was very inconvenient
to actually check the proper end of the address space. And nobody had
really ever bothered to fix it up. As a result, the main user
(getname()) had its own special magic workarounds for this.

Until 3.4. We now do strncpy_from_user() properly, with all the
appropriate error cases of hitting the end of the user address space
etc handled.

And now that the 3.5 merge window is open, some of the first merging I
did was my own branches that had been pending. Including the one that
removes all the hackery from getname(), and expects
strncpy_from_user() to just work right.

If any architecture copied the lazy x86 strncpy_from_user(), they
really do need to fix themselves now. You can actually take the new
all-C x86 implementation, and just strip away the word-at-a-time
optimizations, and it should be pretty generic (if perhaps not
optimal).

The thing to really look out for is when the top of the user address
space abuts the kernel address space. If you *only* rely on page
faults, the user can read kernel addresses by mapping the very last
page and then putting a non-terminated string at the end of that page,
and trying to open a file using that name. So you need to either have
a guard page (guaranteeing a fault), or you need to take TASK_SIZE or
similar into account. Because getname() no longer does the TASK_SIZE
games for you.

                       Linus

On Fri, Apr 6, 2012 at 2:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but what is perhaps more interesting (and the reason linux-arch is
> cc'd) is that not only is it noticeably faster, it should also
> actually get all the error cases right.
>
> What do I mean by that?
>
> I mean that in my tree (but not committed), I have actually removed
> this nasty piece of code from fs/namei.c:
>
> =A0diff --git a/fs/namei.c b/fs/namei.c
> =A0index 0062dd17eb55..2b7d691523bb 100644
> =A0--- a/fs/namei.c
> =A0+++ b/fs/namei.c
> =A0@@ -119,14 +119,7 @@
> =A0 static int do_getname(const char __user *filename, char *page)
> =A0 {
> =A0 =A0 =A0 =A0 =A0int retval;
> =A0- =A0 =A0 =A0 unsigned long len =3D PATH_MAX;
> =A0-
> =A0- =A0 =A0 =A0 if (!segment_eq(get_fs(), KERNEL_DS)) {
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((unsigned long) filename >=3D TA=
SK_SIZE)
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TASK_SIZE - (unsigned long) file=
name < PATH_MAX)
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D TASK_SIZE - =
(unsigned long) filename;
> =A0- =A0 =A0 =A0 }
> =A0+ =A0 =A0 =A0 const unsigned long len =3D PATH_MAX;
>
> =A0 =A0 =A0 =A0 =A0retval =3D strncpy_from_user(page, filename, len);
> =A0 =A0 =A0 =A0 =A0if (retval > 0) {
>
> which worked around the fact that strncpy_from_user() didn't really
> get the end conditions quite right, and it really just did an
> access_ok() on the first byte. The new x86 implementation should get
> all of that right without any need for any ugly hacks.
>
> Now, I haven't committed that change to do_getname(), but it *will*
> get committed at some point.
