Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:33279 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037AbXLQXaA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2007 18:30:00 -0500
Date: Tue, 18 Dec 2007 00:29:58 +0100 (CET)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] Avoid overflows in kernel/time.c (version 3)
In-Reply-To: <200712172228.lBHMSW3i019555@tazenda.hos.anvin.org>
Message-ID: <Pine.LNX.4.64.0712180028430.32270@fbirervta.pbzchgretzou.qr>
References: <200712172228.lBHMSW3i019555@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Michael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, "William L. Irwin" <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>


On Dec 17 2007 13:53, H. Peter Anvin wrote:

>index 0000000..fd46b3d
>--- /dev/null
>+++ b/kernel/timeconst.pl

Could this live in scripts/ too? (And use CodingStyle?)


