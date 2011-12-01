From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/unistd.h: support new process_vm_{readv,write} syscalls
Date: Thu, 01 Dec 2011 23:48:42 +0100
Message-ID: <12496289.FSF46xab1G@wuerfel>
References: <201112011815.pB1IFACw004908@farm-0002.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61797 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab1LAWsy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2011 17:48:54 -0500
In-Reply-To: <201112011815.pB1IFACw004908@farm-0002.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org

On Thursday 01 December 2011 12:54:31 Chris Metcalf wrote:
> Also prototype the "compat" functions so they can be referenced
> from C code.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  include/asm-generic/unistd.h |    8 +++++++-
>  include/linux/compat.h       |    9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Chris, I don't have any other patches for asm-generic right now. Can you handle
this through the tile tree?

	Arnd
