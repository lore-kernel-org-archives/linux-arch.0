From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dirty/Access bits vs. page content
Date: Tue, 22 Apr 2014 15:08:14 -0700
Message-ID: <CA+55aFxcPzHZ28CSyzq4sLakDLXVWgzQzk_D0SqU0qq5kW9cAg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5356E33F.3000908@intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 22, 2014 at 2:46 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>
> I just triggered it a second time.  It only happens with my debugging
> config[1] *and* those two fix patches.  It doesn't happen on the vanilla
> kernel with lost dirty bit.

Ok. So looking at it some more, I'm becoming more and more convinced
that we do need to make that set_page_dirty() call in
free_pages_and_swap_cache() be a set_page_dirty_lock() instead.

Does that make things work for you?

             Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
