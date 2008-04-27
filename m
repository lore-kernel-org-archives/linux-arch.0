Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46480 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863AbYD0MhB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 08:37:01 -0400
Date: Sun, 27 Apr 2008 14:36:42 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Message-ID: <20080427123642.GA28005@elte.hu>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <20080427115603.GA23493@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080427115603.GA23493@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080427123642.mdGH9hunnf5Wa_UgTM-6eEREvKnNkaXlNcwDcctsgtE@z>


* Sam Ravnborg <sam@ravnborg.org> wrote:

> > My opinion on this is still:
> > "OPTIMIZE" means "work around bugs in the kernel".
> 
> So then let us name it: GCC_INLINING

i object to that - please keep it named the way we came up with: 
OPTIMIZE_INLINING=y - because that's what it does.

It goes along the same line as CC_OPTIMIZE_FOR_SIZE=y. Perhaps rename it 
to CC_OPTIMIZE_INLINING=y?

	Ingo
