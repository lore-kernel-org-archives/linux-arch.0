From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Date: Tue, 14 Apr 2020 21:31:49 +1000
Message-ID: <1586863573.ufpx8o7f0i.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-2-npiggin@gmail.com>
        <20200413133444.GM21484@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439311AbgDNLdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 07:33:25 -0400
In-Reply-To: <20200413133444.GM21484@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org

Excerpts from Matthew Wilcox's message of April 13, 2020 11:34 pm:
> On Mon, Apr 13, 2020 at 10:53:00PM +1000, Nicholas Piggin wrote:
>> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
>> Whether or not a vmap is huge depends on the architecture details,
>> alignments, boot options, etc., which the caller can not be expected
>> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
>>=20
>> This change teaches vmalloc_to_page about larger pages, and returns
>> the struct page that corresponds to the offset within the large page.
>> This makes the API agnostic to mapping implementation details.
>=20
> I'm trying to get us away from returning tail pages from various
> functions.  How much of a pain would it be to return the head page
> instead of the tail page?

Well, this is a fix for the interface for HUGE_VMAP stuff so it
doesn't really make sense to change the implementation here. If you
want to change or make a different API that would be a later patch, no?

> Obviously the implementation gets simpler,
> but can the callers cope?  I've been focusing on the page cache, so I
> haven't been looking at the vmalloc side of things at all.

Well callers that operate on ioremap today (and vmalloc tomorrow) won't
cope, because they're expecting a base page. If you wanted to change it
I suspect the way to go would be introduce a new function and move
everyone over individually.

Thanks,
Nick
