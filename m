Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:2418 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbXLXCvF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 23 Dec 2007 21:51:05 -0500
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Avoid overflows in kernel/time.c (version 5)
Date: Mon, 24 Dec 2007 01:14:12 +0100
References: <200712180541.lBI5fnqB028037@tazenda.hos.anvin.org>
In-Reply-To: <200712180541.lBI5fnqB028037@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712240114.13431.zippel@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Michael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "William L. Irwin" <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>, Jan Engelhardt <jengelh@computergmbh.de>

Hi,

On Monday 17 December 2007, H. Peter Anvin wrote:

>  kernel/timeconst.pl           |  340

I agree with Jan that it would be better to put this into scripts.
In the long term we could also detect some of the simple special cases, so we 
can finally inline some of these functions again, this would mean the 
generated file would go into include/linux/ and the script should be in 
scripts/.

> +	my ($b,$n,$d) = @_;

I noticed this already in the old script, using something else than single 
letter variables would increase readability considerably.

bye, Roman
