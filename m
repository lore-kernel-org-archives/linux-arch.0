Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:63523 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbXLUTgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2007 14:36:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Date: Fri, 21 Dec 2007 20:36:27 +0100
References: <20071220115200.C767E26F98A@magilla.localdomain> <20071221085609.4D53B26F98A@magilla.localdomain> <20071221175106.GB17656@fattire.cabal.ca>
In-Reply-To: <20071221175106.GB17656@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200712212036.29098.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Roland McGrath <roland@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Friday 21 December 2007, Kyle McMartin wrote:
> Just taking a stab that hch means,
> 
> config BINFMT_COMPAT_ELF
>         def_bool n
>         depends on 64BIT
> 

I'd call it COMPAT_BINFMT_ELF, for consistency with the file name.
Also, the definition and the depends are redundant if you expect the
option to be autoselected. You can do either of

config COMPAT_BINFMT_ELF
	bool

or 

config COMPAT_BINFMT_ELF
	def_bool y
	depends on COMPAT

The second option makes sense at the point where all architectures with
compat code are using the same compat_binfmt_elf code.

	Arnd <><
