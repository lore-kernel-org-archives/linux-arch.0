Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:35327 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751392AbWIOIHb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 04:07:31 -0400
Date: Fri, 15 Sep 2006 10:06:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0609151000480.4692@pademelon.sonytel.be>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@linux.intel.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, spyro@f2s.com, tony.luck@intel.com, Roman Zippel <zippel@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 14 Sep 2006 akpm@osdl.org wrote:
> According to the SuSv3 spec, "if the application requests only PROT_WRITE,
> the implementation may also allow read access." Also as mentioned, some
> archtectures, such as alpha, shown above already take the approach that i am
> suggesting.
>
> The counter-argument to this raised by Arjan, is that the kernel is enforcing
> the write only mapping the best it can given the h/w limitations.  This is
> true, however Alan Cox, and myself would argue that the inconsitency in
> behavior, that is applications can sometimes work/sometimes fails is highly
> undesireable.  If you read through the thread, i think people, came to an
> agreement on the last patch i posted, as nobody has objected to it...

The same can be said about not initializing local variables, using delete vs.
delete [], ...: sometimes it works, sometimes it fails. It's still an
application bug to rely on `may' behavior.

So I tend to agree with Arjan.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
