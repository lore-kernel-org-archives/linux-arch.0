From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Generic section maintainers
Date: Wed, 3 Aug 2016 23:28:40 -0500
Message-ID: <20160804042840.k355wibzjp5yikxb@treble>
References: <CAB=NE6VpHJLicvrKhPhQD4p+hNRCpvPJU7AXFAQdxXeDWfPLJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcHDE2m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Aug 2016 00:28:42 -0400
Content-Disposition: inline
In-Reply-To: <CAB=NE6VpHJLicvrKhPhQD4p+hNRCpvPJU7AXFAQdxXeDWfPLJQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>

On Wed, Aug 03, 2016 at 12:56:22PM -0700, Luis R. Rodriguez wrote:
> Arnd, Josh,
> 
> In my linker table work [0], other than the linker table work and
> section ranges stuff, I'm adding:
> 
> o include/linux/sections.h
> o include/asm-generic/section-core.h (not in RFC v3 but it is in my
> RFC v4 series not yet posted, splitting this up fixes compilation on
> powerpc which otherwise creates a header issue nightmare to resolve)
> 
> I extend include/asm-generic/sections.h to then include
> <asm-generic/section-core.h>, and furthermore provide the beginning of
> a central place to document in a central place all common sections.
> 
> As per checkpatch complaints I'll be adding myself to MAINTAINERS for
> the linker table headers, section ranges, but noticed then we don't
> have anyone in particularly looking carefully after
> include/asm-generic/sections.h other than the default which is Arnd.
> Given this work on streamlining the section stuff, I'd like to help so
> am considering adding a specific entry on MAINTAINRERS for generic
> sections and adding myself to it along with Arnd. Wanted to check if
> this is OK. While at it, it occurred to me that you might be
> interested in this a swell Josh, given your work with objtool. Would
> anyone else like to help with active maintenance / review of these ?
> 
> So is this OK to merge into my series into the patch "sections.h: add
> sections header to collect all section info".
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49b354cb455a..9919277c66ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5190,6 +5190,18 @@ S: Supported
>  F: drivers/base/power/domain*.c
>  F: include/linux/pm_domain.h
> 
> +GENERIC SECTIONS
> +M: "Luis R. Rodriguez" <mcgrof@kernel.org>
> +M: Josh Poimboeuf <jpoimboe@redhat.com>
> +M: Arnd Bergmann <arnd@arndb.de>
> +L: linux-arch@vger.kernel.org
> +L: linux-kernel@vger.kernel.org
> +S: Supported
> +F: include/asm-generic/section-core.h
> +F: include/asm-generic/sections.h
> +F: include/asm-generic/vmlinux.lds.h
> +F: Documentation/DocBook/sections.tmpl

Hi Luis,

Thanks to my past work with objtool and kpatch, I know far more than I
ever wanted to know about all the kernel's custom ELF sections.  So it's
fine with me if you want to add me as a maintainer for those files.

-- 
Josh
