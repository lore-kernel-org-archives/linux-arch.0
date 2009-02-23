From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Mon, 23 Feb 2009 09:23:50 +0100
Message-ID: <10f740e80902230023y201612e3j3dc5850055deb507@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
	 <cfd18e0f0902221920o3fafe56w73e3534dfe355abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:60678 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZBWIXx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Feb 2009 03:23:53 -0500
Received: by fxm11 with SMTP id 11so1460300fxm.13
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2009 00:23:50 -0800 (PST)
In-Reply-To: <cfd18e0f0902221920o3fafe56w73e3534dfe355abb@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On Mon, Feb 23, 2009 at 04:20, Michael Kerrisk
<mtk.manpages@googlemail.com> wrote:
> * Generally POSIX requires that each error name must have  distinct
> associated value.  EAGAIN and EWOULDBLOCK are one of the few
> exceptions: POSIX permits, but does not require, that these error
> constants have the same value.  On most systems they of course do have
> the same value.  HP-UX is the most notable exception.

And VxWorks (which is probably used more than HP-UX).

Causes interesting compiler problems when porting code from VxWorks to
Linux that has

     case -EGAIN:
     case -EWOULDBLOCK:

Oops, duplicate case value...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
