From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 8 May 2020 16:49:17 -0700
Message-ID: <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgEHXtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 19:49:31 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2009C2496F
        for <linux-arch@vger.kernel.org>; Fri,  8 May 2020 23:49:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id r26so12544043wmh.0
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2020 16:49:31 -0700 (PDT)
In-Reply-To: <20200508213609.GU8135@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>

On Fri, May 8, 2020 at 2:36 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> > On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> > What's the maximum on other system types?  It might make more sense to
> > take the memory hit and pre-populate all the tables at boot so we
> > never have to sync them.
>
> Need to look it up for 5-level paging, with 4-level paging its 64 pages
> to pre-populate the vmalloc area.
>
> But that would not solve the problem on x86-32, which needs to
> synchronize unmappings on the PMD level.

What changes in this series with x86-32?  We already do that
synchronization, right?  IOW, in the cases where the vmalloc *fault*
code does anything at all, we should have a small bound for how much
memory to preallocate and, if we preallocate it, then there is nothing
to sync and nothing to fault.  And we have the benefit that we never
need to sync anything on 64-bit, which is kind of nice.

Do we actually need PMD-level things for 32-bit?  What if we just
outlawed huge pages in the vmalloc space on 32-bit non-PAE?

Or maybe the net result isn't much of a cleanup after all given the
need to support 32-bit.

>
>
>         Joerg
