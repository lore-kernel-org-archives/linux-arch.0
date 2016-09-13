Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34740 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbcIMCQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 22:16:55 -0400
Date: Tue, 13 Sep 2016 12:16:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 1/2] mm, mincore2(): retrieve dax and tlb-size
 attributes of an address range
Message-ID: <20160913121645.652e6512@roar.ozlabs.ibm.com>
In-Reply-To: <CAPcyv4hS7i1DApKPDB5PkfBNZVbk321FgP94kUDjmuyGXDidZg@mail.gmail.com>
References: <147361509579.17004.5258725187329709824.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20160912133536.1bdb57a9@roar.ozlabs.ibm.com>
        <CAPcyv4hS7i1DApKPDB5PkfBNZVbk321FgP94kUDjmuyGXDidZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux MM <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-api@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org
Message-ID: <20160913021645.NoBHlrqzpISA9Pl0ENN_tFjkhcgO3n6zjgzn153r2lo@z>

On Mon, 12 Sep 2016 10:29:17 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Sep 11, 2016 at 8:35 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Sun, 11 Sep 2016 10:31:35 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> >> As evidenced by this bug report [1], userspace libraries are interested
> >> in whether a mapping is DAX mapped, i.e. no intervening page cache.
> >> Rather than using the ambiguous VM_MIXEDMAP flag in smaps, provide an
> >> explicit "is dax" indication as a new flag in the page vector populated
> >> by mincore.  
> >
> > Can you cc linux-arch when adding new syscalls (or other such things that
> > need arch enablement).
> >
> > I wonder if the changelog for a new syscall should have a bit more grandeur.
> > Without seeing patch 2, you might not know this was a new syscall just by
> > reading the subject and changelog.  
> 
> Fair point, I'll beef up the documentation if this moves past an RFC.

Okay. Also, it would be good to summarise some of the justification
directly in the changelog rather than external link. Performance
numbers, etc.


> > mincore() defines other bits to be reserved, but I guess it probably breaks
> > things if you suddenly started using them.  
> 
> The new bits are left as zero unless an application explicitly asks
> for them, so an existing mincore() user shouldn't break.

Oh yeah, I was just musing that we can't really use the old syscall
despite it claims to have some reserved bits for future use.


> > It's a bit sad to introduce a new syscall for this and immediately use up
> > all bits that can be returned. Would it be a serious problem to return a
> > larger mask per page?  
> 
> Certainly one of the new request flags can indicate that the vector is
> made up of larger entries.

Hmm. Changing prototype depending on flags. I thought I was having
a nightmare about ioctls for a minute there :)

In general, is this what we want for a new API? Should we be thinking
about an extent API?

Thanks,
Nick
