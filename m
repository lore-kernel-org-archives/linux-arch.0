Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60523 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751737AbdGZMrI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jul 2017 08:47:08 -0400
Date: Wed, 26 Jul 2017 14:47:04 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/1] mm/hugetlb: Make huge_pte_offset() consistent and
 document behaviour
Message-ID: <20170726124704.GQ2981@dhcp22.suse.cz>
References: <20170725154114.24131-1-punit.agrawal@arm.com>
 <20170725154114.24131-2-punit.agrawal@arm.com>
 <20170726085038.GB2981@dhcp22.suse.cz>
 <20170726085325.GC2981@dhcp22.suse.cz>
 <87bmo7jt31.fsf@e105922-lin.cambridge.arm.com>
 <20170726123357.GP2981@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726123357.GP2981@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, kirill.shutemov@linux.intel.com, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20170726124704.ryfyAg8YcOBiU7Z41gBMyv9dKQMPc3XDIcj1Z3jZ-Vk@z>

On Wed 26-07-17 14:33:57, Michal Hocko wrote:
> On Wed 26-07-17 13:11:46, Punit Agrawal wrote:
[...]
> > I've been running tests from mce-test suite and libhugetlbfs for similar
> > changes we did on arm64. There could be assumptions that were not
> > exercised but I'm not sure how to check for all the possible usages.
> > 
> > Do you have any other suggestions that can help improve confidence in
> > the patch?
> 
> Unfortunatelly I don't. I just know there were many subtle assumptions
> all over the place so I am rather careful to not touch the code unless
> really necessary.
> 
> That being said, I am not opposing your patch.

Let me be more specific. I am not opposing your patch but we should
definitely need more reviewers to have a look. I am not seeing any
immediate problems with it but I do not see a large improvements either
(slightly less nightmare doesn't make me sleep all that well ;)). So I
will leave the decisions to others.
-- 
Michal Hocko
SUSE Labs
