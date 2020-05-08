From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 8 May 2020 14:33:19 -0700
Message-ID: <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
References: <20200508144043.13893-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgEHVdd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:33:33 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44062496C
        for <linux-arch@vger.kernel.org>; Fri,  8 May 2020 21:33:32 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id v12so3562472wrp.12
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2020 14:33:32 -0700 (PDT)
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel <jroedel@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>

On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> after the recent issue with vmalloc and tracing code[1] on x86 and a
> long history of previous issues related to the vmalloc_sync_mappings()
> interface, I thought the time has come to remove it. Please
> see [2], [3], and [4] for some other issues in the past.
>
> The patches are based on v5.7-rc4 and add tracking of page-table
> directory changes to the vmalloc and ioremap code. Depending on which
> page-table levels changes have been made, a new per-arch function is
> called: arch_sync_kernel_mappings().
>
> On x86-64 with 4-level paging, this function will not be called more
> than 64 times in a systems runtime (because vmalloc-space takes 64 PGD
> entries which are only populated, but never cleared).

What's the maximum on other system types?  It might make more sense to
take the memory hit and pre-populate all the tables at boot so we
never have to sync them.
