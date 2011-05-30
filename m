From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] thp: unbalanced parenthesis
Date: Mon, 30 May 2011 16:10:28 +0200
Message-ID: <20110530141028.GG19505@random.random>
References: <20110507205549.6bb0f49f@absol.kitzblitz>
 <20110530130209.7ea4d55d@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab1E3OKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 May 2011 10:10:36 -0400
Content-Disposition: inline
In-Reply-To: <20110530130209.7ea4d55d@absol.kitzblitz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Kaiser <nikai@nikai.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 30, 2011 at 01:02:09PM +0200, Nicolas Kaiser wrote:
> Cc'ed Andrea Arcangeli.
> 
> * Nicolas Kaiser <nikai@nikai.net>:
> > Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> > ---
> > Untested.
> > 
> >  include/asm-generic/pgtable.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> > index b4bfe33..b80daee 100644
> > --- a/include/asm-generic/pgtable.h
> > +++ b/include/asm-generic/pgtable.h
> > @@ -88,7 +88,7 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
> >  	pmd_t pmd = *pmdp;
> >  	pmd_clear(mm, address, pmdp);
> >  	return pmd;
> > -})
> > +}
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >  #endif

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

All archs supporting THP aren't using that function so it isn't
possible to notice it in any config but it's better to fix it in case
some arch will use it in the future.

Thanks,
Andrea
