From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 21:21:02 +0000
Message-ID: <201205182121.02706.arnd@arndb.de>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <CA+55aFzfku-5qgVPahu27DLz-y8MUmh7Mw9sq_TyO49Zb0tg=A@mail.gmail.com> <CAMe9rOr883q0OAsh+JGA83ww603y6QSbQJKx+wk2YJfkYcaEdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58903 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132Ab2ERVVZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 17:21:25 -0400
In-Reply-To: <CAMe9rOr883q0OAsh+JGA83ww603y6QSbQJKx+wk2YJfkYcaEdQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>, David Howells <dhowells@redhat.com>

On Friday 18 May 2012, H.J. Lu wrote:
> Since x32 uses the same kernel interface as x86-64 with a few
> exceptions.  The current kernel header files with
> 
> #ifdef __x86_64__
> # define __BITS_PER_LONG 64
> #else
> # define __BITS_PER_LONG 32
> #endif
> 
> #if __BITS_PER_LONG == 64
> Define x86-64 types
> #endif
> 
> work fine for x32 even if long for x32 is 32 bits.  If __BITS_PER_LONG
> is changed to 32 for x32, many types in kernel header files will be
> wrong for x32.
> 

A lot of things are broken if __BITS_PER_LONG is set to 64 in x32 user
space. It was specifically introduced to get around places in exported
headers that incorrectly used '#ifdef CONFIG_64BIT' to define a user
space structure, so that we can depend on whatever the user sees
in bitmasks and other data structures.

	Arnd
