From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 04/17] arm: get rid of superfluous __GFP_REPEAT
Date: Thu, 2 Jun 2016 08:32:31 +0200
Message-ID: <20160602063231.GB1995@dhcp22.suse.cz>
References: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
 <1464599699-30131-5-git-send-email-mhocko@kernel.org>
 <20160601162424.GD19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160601162424.GD19428@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed 01-06-16 17:24:24, Russell King - ARM Linux wrote:
> On Mon, May 30, 2016 at 11:14:46AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > __GFP_REPEAT has a rather weak semantic but since it has been introduced
> > around 2.6.12 it has been ignored for low order allocations.
> > 
> > PGALLOC_GFP uses __GFP_REPEAT but none of the allocation which uses
> > this flag is for more than order-2. This means that this flag has never
> > been actually useful here because it has always been used only for
> > PAGE_ALLOC_COSTLY requests.
> 
> I hear what you say, but...
> 
> commit 8c65da6dc89ccb605d73773b1dd617e72982d971
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Sat Nov 30 12:52:31 2013 +0000
> 
>     ARM: pgd allocation: retry on failure
> 
>     Make pgd allocation retry on failure; we really need this to succeed
>     otherwise fork() can trigger OOMs.
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> and that's the change which introduced this, and it did solve a problem
> for me.  So I'm not happy to give an ack for this change unless someone
> can tell me why adding __GFP_REPEAT back then had a beneficial effect.
> Maybe there was some other bug in the MM layer in 2013 which this change
> happened to solve?

This is hard to tell but from the code snippet I have referenced it
should be pretty clear that the low order really had a nofail semantic.

git grep GFP_REPEAT 8c65da6dc89ccb605d73773b1dd617e72982d971 -- mm
confirms the story.

Do you remember your reproducer?
-- 
Michal Hocko
SUSE Labs
