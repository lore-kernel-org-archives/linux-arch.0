From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 1/2] kbuild: asm-generic support
Date: Thu, 13 Jan 2011 17:14:05 +0100
Message-ID: <4D2F24CD.5040101@suse.cz>
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110109192707.GA12387@merkur.ravnborg.org> <20110109192907.GA12403@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49267 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756717Ab1AMQOI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Jan 2011 11:14:08 -0500
In-Reply-To: <20110109192907.GA12403@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>

On 9.1.2011 20:29, Sam Ravnborg wrote:
> diff --git a/scripts/asm-generic.sh b/scripts/asm-generic.sh
> new file mode 100644
> index 0000000..d28127f
> --- /dev/null
> +++ b/scripts/asm-generic.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +# include/asm-generic contains a lot of files that are used
> +# verbatim by several architectures.
> +#
> +# This scripts read the file arch/$(ARCH)/include/asm/Kbuild
> +# and for each file listed in this file with generic-y create
> +# a small wrapper file in arch/$(ARCH)/include/generated/
> +
> +# read list of header files form Kbuild
> +# The file has make syntax which looks like this:
> +#
> +# generic-y += <filename>
> +
> +srcdir=${srctree}/arch/$1/include/asm
> +gendir=arch/$1/include/generated/asm
> +
> +# Read the list of files (note that the list uses make syntax)
> +files=$( cat ${srcdir}/Kbuild | \
> +          grep -v ^# | grep generic-y | cut -d '=' -f 2)

Now that the list of required generic headers is in a Kbuild file, it
would be better to let make parse it, instead of enforcing one way to
construct the list (it is the preferred way, but C files that do not
conform to Documentation/CodingStyle are not rejected by the compiler
either). I will post a patch when I'm back online in the evening.

Michal
