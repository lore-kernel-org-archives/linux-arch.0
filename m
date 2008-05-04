From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 32/56] microblaze_v2: definitions of types
Date: Sun, 4 May 2008 23:28:44 +0200
Message-ID: <200805042328.45508.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <cfde3796e95bdd17c32e4fd7762d0aee55967707.1209897266.git.monstr@monstr.eu> <8aba2d82c85cd1d5b56de328c1fd080ee51f0211.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55749 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYEDV3R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 17:29:17 -0400
In-Reply-To: <8aba2d82c85cd1d5b56de328c1fd080ee51f0211.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> include/asm-microblaze/posix_types.h

It would be good to have this as asm-generic/posix_types_32.h.
Unfortunately, __kernel_size_t and friends need to match the
compiler and are sometimes defined as 'unsigned int' and
sometimes as 'unsigned long', otherwise we could even use
the same header for 32 and 64 bit.

> +typedef unsigned short	__kernel_mode_t;
> +typedef unsigned short	__kernel_nlink_t;
> +typedef unsigned short	__kernel_ipc_pid_t;

Some architectures define these as 'unsigned int', which
seems reasonable, though there is no real requirement behind it,
afaict.

> +typedef long		__kernel_off_t;

I suppose this should become 'typedef long long __kernel_off_t;'
It won't work on pre-C99 compilers, but I don't think we need
to care about those for a new architecture.

> +typedef unsigned short	__kernel_uid_t;
> +typedef unsigned short	__kernel_gid_t;

this should certainly be unsigned int.

> +typedef unsigned short	__kernel_uid16_t;
> +typedef unsigned short	__kernel_gid16_t;
> +typedef unsigned int	__kernel_uid32_t;
> +typedef unsigned int	__kernel_gid32_t;
> +
> +typedef unsigned short	__kernel_old_uid_t;
> +typedef unsigned short	__kernel_old_gid_t;
> +typedef unsigned short	__kernel_old_dev_t;

try not defining these at all and see if something breaks.
If it does, that's probably a bug.

	Arnd <><
