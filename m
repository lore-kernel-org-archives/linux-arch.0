Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:48678 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaDWCos (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 22:44:48 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so407875veb.32
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 19:44:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5356E33F.3000908@intel.com>
References: <1398032742.19682.11.camel@pasglop>
	<CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com>
	<1398054064.19682.32.camel@pasglop>
	<1398057630.19682.38.camel@pasglop>
	<CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>
	<53558507.9050703@zytor.com>
	<CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	<53559F48.8040808@intel.com>
	<CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	<CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	<20140422075459.GD11182@twins.programming.kicks-ass.net>
	<CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	<5356E33F.3000908@intel.com>
Date: Tue, 22 Apr 2014 19:44:47 -0700
Message-ID: <CA+55aFws4q-ASm33ApBK8Cz8pnTHYWagyDu-58YSCicHVmMRHw@mail.gmail.com>
Subject: Re: Dirty/Access bits vs. page content
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140423024447.pMQmfujPxbs2HP4Dp1uYrtWHEcOAD5Aof8gvb9lXkTU@z>

On Tue, Apr 22, 2014 at 2:46 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>
> The line numbers point to the
>
>         head = page_buffers(page);

Ahh. My tree has an ext4 update, so for me that wasn't the case, and
your line numbers were off.

Hmm. I've stared at it, and I can make neither heads nor tails of it.
I really don't see why moving the set_page_dirty() would matter for
that case. Very odd. I'll mull on it and maybe it comes to me
overnight.

               Linus
