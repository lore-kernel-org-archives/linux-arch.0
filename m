From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Dirty/Access bits vs. page content
Date: Wed, 23 Apr 2014 16:14:15 +1000
Message-ID: <1398233655.19682.135.camel@pasglop>
References: <1398032742.19682.11.camel@pasglop>
	 <CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com>
	 <1398054064.19682.32.camel@pasglop> <1398057630.19682.38.camel@pasglop>
	 <CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>
	 <53558507.9050703@zytor.com>
	 <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	 <53559F48.8040808@intel.com>
	 <CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	 <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	 <20140422075459.GD11182@twins.programming.kicks-ass.net>
	 <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	 <alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
	 <CA+55aFw7JjEBUJRHXuwc7bGBD5c=J41mt46ovwHKAoMfPowWOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CA+55aFw7JjEBUJRHXuwc7bGBD5c=J41mt46ovwHKAoMfPowWOw@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2014-04-22 at 21:23 -0700, Linus Torvalds wrote:
> 
> But I'm starting to consider this whole thing to be a 3.16 issue by
> now. It wasn't as simple as it looked, and while our old location of
> set_page_dirty() is clearly wrong, and DaveH even got a test-case for
> it (which I initially doubted would even be possible), I still
> seriously doubt that anybody sane who cares about data consistency
> will do concurrent unmaps (or MADV_DONTNEED) while another writer is
> actively using that mapping.

I'm more worried about users of unmap_mapping_ranges() than concurrent
munmap(). Things like the DRM playing tricks like swapping a mapping
from memory to frame buffer and vice-versa.

In any case, I agree with delaying that for 3.16, it's still very
unlikely that we hit this in any case that actually matters.

Cheers,
Ben.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
