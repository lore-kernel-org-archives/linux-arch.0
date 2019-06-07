Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35609 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfFGS2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 14:28:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so2589209ljb.2
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 11:28:16 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w17sm497276ljj.31.2019.06.07.11.28.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:28:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id q26so2346076lfc.3
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 11:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87tvd2j9ye.fsf@oldenburg2.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jun 2019 11:27:57 -0700
Message-ID: <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Paul Burton <pburton@wavecomp.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-ID: <20190607182757.aBIkT7p7ukssG_GkCL_QeuxcaQ4keiSlQyf4ShUVQMU@z>

On Thu, Jun 6, 2019 at 9:28 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> This regression fix still hasn't been merged into Linus' tree.  What is
> going on here?

.. it was never sent to me.

That said, now that I see the patch, I wonder why we'd have that
#ifdef __KERNEL__ in here:

 typedef struct {
+#ifdef __KERNEL__
        int     val[2];
+#else
+       int     __kernel_val[2];
+#endif
 } __kernel_fsid_t;

and not just unconditionally do

    int   __fsid_val[2]

If we're changing kernel header files, it's easy enough to change the
kernel users. I'd be more worried about user space that *uses* that
thing, and currently accesses 'val[]' by name.

So the patch looks a bit odd to me. How are people supposed to use
fsid_t if they can't look at it?

The man-page makes it pretty clear that fsid_t is complete garbage,
but it's *documented* garbage:

   The f_fsid field
       Solaris, Irix and POSIX have a system call statvfs(2) that
returns a struct statvfs (defined in <sys/statvfs.h>) containing an
unsigned long f_fsid.  Linux, SunOS, HP-UX, 4.4BSD have a system call
statfs() that returns a  struct
       statfs (defined in <sys/vfs.h>) containing a fsid_t f_fsid,
where fsid_t is defined as struct { int val[2]; }.  The same holds for
FreeBSD, except that it uses the include file <sys/mount.h>.

so that "val[]" name does seem to be pretty much required.

In other words, I don't think the patch is acceptable. User space sees
"val[]" and _needs_ to see it. Otherwise the type is entirely
pointless.

The proper fix is presumably do make sure the fsid_t type definitions
aren't visible to user space at all in this context, and is only
visible in <sys/statvfs.h>.

So now that I _do_ see the patch, there's no way I'll apply it.

               Linus
