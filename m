From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 29 Nov 2008 10:38:58 +0100
Message-ID: <20081129093858.GC26691@elte.hu>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com> <20081129164736.0b5a71db.h.mitake@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:44542 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbYK2JjW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Nov 2008 04:39:22 -0500
Content-Disposition: inline
In-Reply-To: <20081129164736.0b5a71db.h.mitake@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hitoshi Mitake <h.mitake@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Hitoshi Mitake <h.mitake@gmail.com> wrote:

> +#define readq readq
> +#define writeq writeq

hm, that's done to override the generic definition? Looks weird and i 
think that's rather fragile - it's easy to somehow get the generic header 
without this override.

	Ingo
