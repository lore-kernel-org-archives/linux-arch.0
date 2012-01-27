Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:14972 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2A0QrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2012 11:47:03 -0500
Date: Fri, 27 Jan 2012 16:34:24 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
Subject: Re: [PATCHv2 1/2] cpu: Do not return errors from cpu_dev_init()
 which will be ignored; [PATCHv2 2/2] cpu: Register a generic CPU device on
 architectures that currently do not
In-Reply-To: <1326164672.3432.34.camel@deadeye>
Message-ID: <Pine.BSM.4.64L.1201271632120.25139@herc.mirbsd.org>
References: <1326164389.3432.29.camel@deadeye> <1326164672.3432.34.camel@deadeye>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org, Richard Weinberger <richard@nod.at>
Message-ID: <20120127163424.4PP1QWTl9uf3-gppMxyseC9ZaQ2zqmgRV9eydYZQgy0@z>

Ben Hutchings dixit:

>cpu_dev_init() is only called from driver_init(), which does not check
[…]

= and =

>frv, h8300, m68k, microblaze, openrisc, score, um and xtensa currently
>do not register a CPU device.  Add the config option
>GENERIC_CPU_DEVICES which causes a generic CPU device to be registered
[…]

Now that these are in the Debian Linux kernel package and a build has
been done, I can confirm the result boots on ARAnyM (m68k).

Tested-by: Thorsten Glaser <tg@debian.org>

bye,
//mirabilos
-- 
I believe no one can invent an algorithm. One just happens to hit upon it
when God enlightens him. Or only God invents algorithms, we merely copy them.
If you don't believe in God, just consider God as Nature if you won't deny
existence.		-- Coywolf Qi Hunt
