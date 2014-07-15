From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 38/38] asm-generic: introduc Kbuild.generic
Date: Tue, 15 Jul 2014 09:03 +0200
Message-ID: <4667634.oiTEQ4v5vj@wuerfel>
References: <20140714150609.GA28358@ravnborg.org> <1405350546-28467-1-git-send-email-sam@ravnborg.org> <1405350546-28467-38-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56357 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaGOHDG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 03:03:06 -0400
In-Reply-To: <1405350546-28467-38-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Monday 14 July 2014 17:09:06 Sam Ravnborg wrote:
> Kbuild.generic is for asm-generic files that are used
> by all architectures.
> So rather than adding the file to the individual Kbuild files
> it is enough to add it to this file
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

This has been suggested in the past, and I remember there being some
controversy around it, but I don't really mind it, so you have my
ok in principle. Two points though that we have to work out first:

> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> index 96e54be..e09f8e7 100644
> --- a/arch/alpha/include/asm/Kbuild
> +++ b/arch/alpha/include/asm/Kbuild
> @@ -1,9 +1,9 @@
> -
> +# Generic wrappers from include/asm-generic
> +include include/asm-generic/Kbuild.generic

We have the same kind of header for the uapi files, it's called 
include/uapi/asm-generic/Kbuild.asm. I don't know why I picked that
name back then, Kbuild.generic seems more appropriate, but I think
either way it would be good to be consistent.

Can you either rename the existing file to Kbuild.generic, or call
the new one Kbuild.asm as well?

> diff --git a/include/asm-generic/Kbuild.generic b/include/asm-generic/Kbuild.generic
> new file mode 100644
> index 0000000..f44815b
> --- /dev/null
> +++ b/include/asm-generic/Kbuild.generic
> @@ -0,0 +1,6 @@
> +# List of generic header files that is used by all architectures
> +# This file is included by arch/*/include/asm/Kbuild
> +#
> +# Keep the list sorted alphabetically
> +
> +generic-y += mcs_spinlock.h

We have to make up our minds what we want from this list. At the moment,
you list only one file because that is the only file that is shared across
all architectures. The idea for this file is that architectures /can/
provide their own (according to the comments in this file), but no
architecture actually does.  A few thoughts on this:

* Normally we just delete any header file that is common across all
  architectures, and change the files including it (only one is present
  in this case) not to include it. If we do that, your new file becomes
  pointless.

* If one architecture actually starts providing its own version of this
  file, we'd have to revert your patch first, which really defeats the
  purpose of doing it in the first place.

* We could improve the situation if the definition of this list is
  changed so we only generate the generic header files that are not
  already provided by an architecture. If we do this, we can consolidate
  a lot more here, which is nice, but the cost would be equivalent to
  another level of indirection and a potential for subtle bugs if it's
  not done very careful.

	Arnd
