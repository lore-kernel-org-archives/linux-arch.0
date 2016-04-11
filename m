From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 13/19] s390: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 14:47:39 +0200
Message-ID: <20160411124739.GB3976@osiris>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <1460372892-8157-14-git-send-email-mhocko@kernel.org>
 <20160411132837.3cba168f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160411132837.3cba168f.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 11, 2016 at 01:28:37PM +0200, Cornelia Huck wrote:
> On Mon, 11 Apr 2016 13:08:06 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > __GFP_REPEAT has a rather weak semantic but since it has been introduced
> > around 2.6.12 it has been ignored for low order allocations.
> > 
> > arch_dup_task_struct uses __GFP_REPEAT for fpu_regs_size which is either
> > sizeof(__vector128) * __NUM_VXRS = 4069B resp.
> > sizeof(freg_t) * __NUM_FPRS = 1024B AFAICS. page_table_alloc then uses
> > the flag for a single page allocation. This means that this flag has
> > never been actually useful here because it has always been used only for
> > PAGE_ALLOC_COSTLY requests.
> > 
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Let's cc: Martin/Heiko instead :)
> 
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  arch/s390/kernel/process.c | 2 +-
> >  arch/s390/mm/pgalloc.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
