Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59564 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbaDYBin (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Apr 2014 21:38:43 -0400
Message-ID: <1398389846.8437.6.camel@pasglop>
Subject: Re: Dirty/Access bits vs. page content
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 25 Apr 2014 11:37:26 +1000
In-Reply-To: <CA+55aFyUyD_BASjhig9OPerYcMrUgYJUfRLA9JyB_x7anV1d7Q@mail.gmail.com>
References: <53558507.9050703@zytor.com>
	 <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	 <53559F48.8040808@intel.com>
	 <CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	 <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	 <20140422075459.GD11182@twins.programming.kicks-ass.net>
	 <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	 <alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
	 <20140423184145.GH17824@quack.suse.cz>
	 <CA+55aFwm9BT4ecXF7dD+OM0-+1Wz5vd4ts44hOkS8JdQ74SLZQ@mail.gmail.com>
	 <20140424065133.GX26782@laptop.programming.kicks-ass.net>
	 <alpine.LSU.2.11.1404241110160.2443@eggly.anvils>
	 <CA+55aFwVgCshsVHNqr2EA1aFY18A2L17gNj0wtgHB39qLErTrg@mail.gmail.com>
	 <alpine.LSU.2.11.1404241252520.3455@eggly.anvils>
	 <CA+55aFyUyD_BASjhig9OPerYcMrUgYJUfRLA9JyB_x7anV1d7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140425013726.qZlYrz841d8fKBfmiWQIPaGZoBLIKR7JRKmY-uqxFlc@z>

On Thu, 2014-04-24 at 16:46 -0700, Linus Torvalds wrote:
> - we do the TLB shootdown holding the page table lock (but that's not
> new - ptep_get_and_flush does the same
> 

The flip side is that we do a lot more IPIs for large invalidates,
since we drop the PTL on every page table page.

Ben.


