From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 14:48:29 +0200
Message-ID: <1282222109.10440.50.camel@thorin>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
	 <87aaoiu6z6.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87aaoiu6z6.fsf@basil.nowhere.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Don, 2010-08-19 at 14:23 +0200, Andi Kleen wrote:
> Namhyung Kim <namhyung@gmail.com> writes:
> 
> > When I compiled allyesconfig'ed kernel with C=1, I got 1519 lines of
> > following message:
> >
> >  include/linux/mm.h:599:16: warning: potentially expensive pointer subtraction
> >
> > which is around 10% of total warnings. this was caused by page_to_pfn() macro
> > so I think it's worth to remove it by calculating pointer subtraction
> > manually.
> 
> IMHO it would be better to simply disable the warning in sparse instead
> of uglying the code just to work around sparse bogosity. It doesnt' seem
> to make much sense. A subtraction followed by a shift is not expensive.

The code above is IMHO actually (the line with "return" in)
----  snip  ----
static __always_inline void *lowmem_page_address(struct page *page)
{
	return __va(PFN_PHYS(page_to_pfn(page)));
}
----  snip  ----
If so, the warning seems valid as sizeof(struct page) is probably not
(always) a power of 2. On a native build on x86_64 it is 56 bytes
hereover.
Hmm ....

	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services
