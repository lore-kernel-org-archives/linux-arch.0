From: Mark Salter <msalter@redhat.com>
Subject: Re: possible problem with generic asm/types.h
Date: Sat, 25 May 2013 12:43:57 -0400
Message-ID: <1369500237.25297.68.camel@t520.redhat.com>
References: <1369494858.25297.58.camel@t520.redhat.com>
	 <CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
	 <1369499831.25297.67.camel@t520.redhat.com>
	 <CAMuHMdVkz7ToYU39s4daT6fh0ztetZdgaKZqNJDxMcoO==6e4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204Ab3EYQoH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 May 2013 12:44:07 -0400
In-Reply-To: <CAMuHMdVkz7ToYU39s4daT6fh0ztetZdgaKZqNJDxMcoO==6e4w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>

On Sat, 2013-05-25 at 18:39 +0200, Geert Uytterhoeven wrote:
> On Sat, May 25, 2013 at 6:37 PM, Mark Salter <msalter@redhat.com> wrote:
> >> No. Inside the kernel, all 64-bit platforms use int-ll64.h.
> >
> > Except for alpha and ia64...
> 
> Nope:
> 
> $ git grep int-l arch/{alpha,ia64}/include/asm/types.h
> arch/alpha/include/asm/types.h:#include <asm-generic/int-ll64.h>
> arch/ia64/include/asm/types.h:#include <asm-generic/int-ll64.h>
> $

Hmm.

$ git grep int-l arch/{alpha,ia64}/include/uapi/asm/types.h
arch/alpha/include/uapi/asm/types.h:#include <asm-generic/int-l64.h>
arch/ia64/include/uapi/asm/types.h:#include <asm-generic/int-l64.h>
