Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab2J2Km5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Oct 2012 06:42:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1351489774-14263-2-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-2-git-send-email-gerg@snapgear.com> <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Subject: Re: [PATCH v2 01/11] m68k: switch to using the asm-generic auxvec.h
Date: Mon, 29 Oct 2012 10:42:48 +0000
Message-ID: <18903.1351507368@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gerg@snapgear.com
Cc: dhowells@redhat.com, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121029104248.w18KmHYWdtraIe4Xxi1pHTTKq5RwR98EqlP1yEl01Tk@z>

<gerg@snapgear.com> wrote:

> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> index 972bce1..588c3cc 100644
> --- a/arch/m68k/include/uapi/asm/Kbuild
> +++ b/arch/m68k/include/uapi/asm/Kbuild
> @@ -2,7 +2,6 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  header-y += a.out.h
> -header-y += auxvec.h
>  header-y += byteorder.h
>  header-y += cachectl.h
>  header-y += fcntl.h

Rather than removing header-y from the uapi Kbuild, you probably want to add a
generic-y there.

David
