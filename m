From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Xen-devel] [PATCH] Xen: remove -fshort-wchar gcc flag
Date: Thu, 11 Aug 2016 16:01:40 +0200
Message-ID: <1924668.nNs2RHZJcd@wuerfel>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com> <16541778.WMH6K24aDt@wuerfel> <57AC90F5020000780010515A@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:60474 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcHKOCZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 10:02:25 -0400
In-Reply-To: <57AC90F5020000780010515A@prv-mh.provo.novell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Vrabel <david.vrabel@citrix.com>, Alan Modra <amodra@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, Nicolas Pitre <nico@linaro.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Sam Ravnborg <sam@ravnborg.org>, Juergen Gross <JGross@suse.com>, Michal Marek <MMarek@suse.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org

On Thursday, August 11, 2016 6:51:33 AM CEST Jan Beulich wrote:
> >>> On 11.08.16 at 14:39, <arnd@arndb.de> wrote:
> > A previous patch added the --no-wchar-size-warning to the Makefile to
> > avoid this harmless warning:
> > 
> > arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the 
> > output is to use 4-byte wchar_t; use of wchar_t values across objects may 
> > fail
> > 
> > Changing kbuild to use thin archives instead of recursive linking
> > unfortunately brings the same warning back during the final link.
> > 
> > This time, we remove the -fshort-wchar flag that originally caused
> > the warning, hopefully fixing the problem for good. I don't see
> > any reason for having the flag in the first place, as the Xen code
> > does not use wchar_t at all.
> 
> It uses efi_char16_t, and by dropping -fshort-wchar you'd open
> up a trap for anyone to fall into who were to add wide string
> literals to that same file. EFI using 16-bit characters requires
> code interfacing with EFI to do so too.

I don't understand. How is this different from other source files
that use efi_char16_t or the wchar_t definition from include/linux/nls.h?

As far as I can tell, they all use 16-bit characters, but none of the
others sets the flag. Maybe we should just always build with -fshort-wchar
from the top-level Makefile?

	Arnd
