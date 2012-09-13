From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH 0/3] Minor changes to common hugetlb code for ARM
Date: Thu, 13 Sep 2012 14:22:11 +0200
Message-ID: <20120913122211.GD8055@dhcp22.suse.cz>
References: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
 <20120912152759.GR21579@dhcp22.suse.cz>
 <20120912155555.GF32234@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36907 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab2IMMWN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Sep 2012 08:22:13 -0400
Content-Disposition: inline
In-Reply-To: <20120912155555.GF32234@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>

On Wed 12-09-12 16:55:55, Will Deacon wrote:
> On Wed, Sep 12, 2012 at 04:27:59PM +0100, Michal Hocko wrote:
> > On Tue 11-09-12 17:47:13, Will Deacon wrote:
> > > A few changes are required to common hugetlb code before the ARM support
> > > can be merged. I posted the main one previously, which has been picked up
> > > by akpm:
> > > 
> > >   http://marc.info/?l=linux-mm&m=134573987631394&w=2
> > > 
> > > The remaining three patches (included here) are all fairly minor but do
> > > affect other architectures.
> > 
> > I am quite confused. Why THP changes are required for hugetlb code for
> > ARM?
> 
> Sorry, I was being too vague. We add ARM support for THP in the same patch
> series as hugetlb, so I was loosely referring to that lot.

OK, it makes more sense now. Thanks for the clarification.

-- 
Michal Hocko
SUSE Labs
