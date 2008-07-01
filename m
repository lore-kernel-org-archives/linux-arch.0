Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54525 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbYGAW7o (ORCPT
	<RFC822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:59:44 -0400
Subject: Re: [PATCH 1/23] make section names compatible with -ffunction-sections -fdata-sections
In-Reply-To: Your message of "Wed, 02 Jul 2008 02:33:48 +0200."
             <200807020233.48646.vda.linux@googlemail.com>
From: Valdis.Kletnieks@vt.edu
References: <200807020233.48646.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1214952973_2982P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jul 2008 18:56:13 -0400
Message-ID: <60320.1214952973@turing-police.cc.vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
Message-ID: <20080701225613.AHtDc8m8Z6n-4U4GEvG8ze1TyWxkud0xnNVvNSrxUcY@z>

--==_Exmh_1214952973_2982P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jul 2008 02:33:48 +0200, Denys Vlasenko said:

> The purpose of these patches is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> 
> Newer gcc and binutils can do dead code and data removal
> at link time. It is achieved using combination of
> -ffunction-sections -fdata-sections options for gcc and
> --gc-sections for ld.

Interesting idea.  Do you happen to have before-and-after 'size vmlinux'
numbers to show how much space is actually reclaimed?

--==_Exmh_1214952973_2982P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFIarYNcC3lWbTT17ARAh9sAJ9xjYck9zBa6K8R7tTHzDIj28eiwACeOD8Q
hdump+CXw2+ZexG6of1uSVQ=
=RKDh
-----END PGP SIGNATURE-----

--==_Exmh_1214952973_2982P--
