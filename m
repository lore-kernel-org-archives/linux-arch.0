Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34350 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756080AbcILDfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2016 23:35:46 -0400
Date: Mon, 12 Sep 2016 13:35:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 1/2] mm, mincore2(): retrieve dax and tlb-size
 attributes of an address range
Message-ID: <20160912133536.1bdb57a9@roar.ozlabs.ibm.com>
In-Reply-To: <147361509579.17004.5258725187329709824.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147361509579.17004.5258725187329709824.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-nvdimm@lists.01.org, linux-api@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org
Message-ID: <20160912033536.6e2cQTRViylX5fxwQ6bi8-laKsIlNaZIffKjASD9CzA@z>

On Sun, 11 Sep 2016 10:31:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> As evidenced by this bug report [1], userspace libraries are interested
> in whether a mapping is DAX mapped, i.e. no intervening page cache.
> Rather than using the ambiguous VM_MIXEDMAP flag in smaps, provide an
> explicit "is dax" indication as a new flag in the page vector populated
> by mincore.

Can you cc linux-arch when adding new syscalls (or other such things that
need arch enablement).

I wonder if the changelog for a new syscall should have a bit more grandeur.
Without seeing patch 2, you might not know this was a new syscall just by
reading the subject and changelog.

mincore() defines other bits to be reserved, but I guess it probably breaks
things if you suddenly started using them.

It's a bit sad to introduce a new syscall for this and immediately use up
all bits that can be returned. Would it be a serious problem to return a
larger mask per page?

Thanks,
Nick
