From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 21/21] posix_types: Remove fd_set macros
Date: Wed, 08 Feb 2012 21:24:22 +0000
Message-ID: <16325.1328736262@redhat.com>
References: <4F32A98F.7030400@zytor.com> <1328677745-20121-22-git-send-email-hpa@zytor.com> <1328677745-20121-1-git-send-email-hpa@zytor.com> <8328.1328703626@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F32A98F.7030400@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:

> Anyway, select() paraphernalia goes in <sys/time.h> (as opposed to
> <time.h>), poll() paraphernalia goes in <sys/poll.h>, and the linux/*
> files mimics that.

That doesn't seem to be so - at least not for my copy of glibc:

/usr/include/sys/select.h:/* fd_set for select and pselect.  */
/usr/include/sys/select.h:  } fd_set;
/usr/include/sys/select.h:#define       FD_ISSET(fd, fdsetp)    __FD_ISSET (fd, fdsetp)

Besides, this is inside the kernel.  The I/O polling architecture definitions
(which includes select) ought to be in one place there, not spread out all
over the place.

David
