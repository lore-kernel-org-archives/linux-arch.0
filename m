From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH] Xen: remove -fshort-wchar gcc flag
Date: Wed, 24 Aug 2016 18:18:34 +0100
Message-ID: <57BDD6EA.70204@citrix.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
 <16541778.WMH6K24aDt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:3502 "EHLO SMTP02.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbcHXRTT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Aug 2016 13:19:19 -0400
In-Reply-To: <16541778.WMH6K24aDt@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Juergen Gross <jgross@suse.com>, Segher Boessenkool <segher@kernel.crashing.org>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org, Alan Modra <amodra@gmail.com>, Michal Marek <mmarek@suse.com>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Sam Ravnborg <sam@ravnborg.org>

On 11/08/16 13:39, Arnd Bergmann wrote:
> A previous patch added the --no-wchar-size-warning to the Makefile to
> avoid this harmless warning:
> 
> arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the output is to use 4-byte wchar_t; use of wchar_t values across objects may fail
> 
> Changing kbuild to use thin archives instead of recursive linking
> unfortunately brings the same warning back during the final link.
> 
> This time, we remove the -fshort-wchar flag that originally caused
> the warning, hopefully fixing the problem for good. I don't see
> any reason for having the flag in the first place, as the Xen code
> does not use wchar_t at all.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 971a69db7dc0 ("Xen: don't warn about 2-byte wchar_t in efi")

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
