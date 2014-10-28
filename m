From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATCH V3 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Date: Tue, 28 Oct 2014 10:44:52 +0000
Message-ID: <20141028104451.GB4187@linaro.org>
References: <1414233860-7683-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
 <1414459229.31711.0.camel@concordia>
 <20141027183241.a5339085.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141027183241.a5339085.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, benh@kernel.crashing.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 27, 2014 at 06:32:41PM -0700, Andrew Morton wrote:
> On Tue, 28 Oct 2014 12:20:29 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Mon, 2014-10-27 at 16:06 -0700, Andrew Morton wrote:
> > > On Sat, 25 Oct 2014 16:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> > > 
> > > > Update generic gup implementation with powerpc specific details.
> > > > On powerpc at pmd level we can have hugepte, normal pmd pointer
> > > > or a pointer to the hugepage directory.
> > > 
> > > I grabbed these.  It would be better if they were merged into the powerpc
> > > tree where they'll get more testing than in linux-next alone.
> >  
> > Fine by me. Can I get an ack from you and/or someone else on CC?
> > 
> 
> Only arm and arm64 use this code.  Steve, could you please look it over
> and check that arm is still happy?

Hi Andrew,
I've tested it and posted some comments on it.

If the arch/arm and arch/arm64 changes are removed and a comment about
an assumption made by the new gup_huge_pte code is added then I'm happy.

Cheers,
-- 
Steve

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
