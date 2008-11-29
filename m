From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 29 Nov 2008 19:26:10 +0900
Message-ID: <20081129192610.716a2d57.h.mitake@gmail.com>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com>
	<20081129164736.0b5a71db.h.mitake@gmail.com>
	<20081129093858.GC26691@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:53868 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYK2K0S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Nov 2008 05:26:18 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1200654tic.23
        for <linux-arch@vger.kernel.org>; Sat, 29 Nov 2008 02:26:15 -0800 (PST)
In-Reply-To: <20081129093858.GC26691@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, 29 Nov 2008 10:38:58 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Hitoshi Mitake <h.mitake@gmail.com> wrote:
> 
> > +#define readq readq
> > +#define writeq writeq
> 
> hm, that's done to override the generic definition? Looks weird and i 
> think that's rather fragile - it's easy to somehow get the generic header 
> without this override.

No, the purpose of this #define is to let user of this function to know there's readq/writeq.
Like this,

#ifdef readq
/* do something */
#endif

But this is old way. ARCH_HAS_READQ and ARCH_HAS_WRITEQ are new ways
to determine existence of readq/writeq. Drivers which use readq/writeq should
depend on these values in their Kconfig file.

This definitions may be redundant. But there are some architectures
which already have this definition for same purpose. So I added.

Should I remove these?
