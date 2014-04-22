From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Dirty/Access bits vs. page content
Date: Mon, 21 Apr 2014 22:15:27 -0700
Message-ID: <CA+8MBbLvWuSfP+7CFwAmSwNX7Uekob5p52BuwfkW=oz9=202HQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 21, 2014 at 5:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I think Russell and Tony are both on linux-arch, so they probably saw
> at least part of this discussion flow past already, but just in case
> I'm adding them explicitly to the cc, because both ia64 and arm seem
> to implement their own version of TLB batching rather than use the
> generic code.

It builds and boots on ia64 with no new warnings.  I haven't done
anything more stressful than booting though - so unsure whether
there are any corners cases that might show up under load.

-Tony

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
