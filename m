From: Andy Lutomirski <luto@amacapital.net>
Subject: Unifying vdso implementations across architectures?
Date: Fri, 16 May 2014 14:59:49 -0700
Message-ID: <CALCETrU6wEoBAESp68NrBMack3jd0ofgw9PM+uNFnCnFEvVnNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:36656 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbaEPWAK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 May 2014 18:00:10 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so3881890veb.30
        for <linux-arch@vger.kernel.org>; Fri, 16 May 2014 15:00:09 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>

Hi all-

I've spent a bunch of time cleaning up the x86 vdso implementation.
In linux-next (via tip/x86/vdso), there is a build-time helper vdso2c
that takes a .so.dbg file and generates a .c file that describes the
vdso image.  That helper can extract symbols, find the alternative
patching instructions, check for undefined symbols, fully strip the
image, and set up a nice data structure that contains pretty much all
of the information needed to map the vdso.  The helper and the linker
script know how to set up any number of pages immediately after the
vdso mapping that can be referenced (in a pc-relative manner) from the
vdso to do useful things like timing.

I'm currently working on further improvements to remove the need for
arch_vma_name and such.

Would there be interest in trying to unify this stuff across
architectures?  AFAICT a lot of architectures contain copies of pretty
much the same code.

Note that I'm talking about real vdsos, not magic pages that are
mapped in kernel address space.  The latter is awful and should be
eliminated whenever possible.  I still don't understand why ARM has
one of these.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
