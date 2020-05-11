Return-Path: <SRS0=Roe3=6Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUus (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 16:50:48 -0400
Date: Mon, 11 May 2020 16:50:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200511165045.36198080@gandalf.local.home>
In-Reply-To: <20200511191414.GY8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
        <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
        <20200508213609.GU8135@suse.de>
        <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
        <20200509175217.GV8135@suse.de>
        <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
        <20200511074243.GE2957@hirez.programming.kicks-ass.net>
        <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
        <20200511191414.GY8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Message-ID: <20200511205045.cJmi3neS-Qv4hRTwYvT3VamnanIS6KUZh4yNMqEMQfg@z>

On Mon, 11 May 2020 21:14:14 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> > Or maybe we don't want to defeature this much, or maybe the memory hit
> > from this preallocation will hurt little 2-level 32-bit systems too
> > much.  
> 
> It will certainly make Linux less likely to boot on low-memory x86-32
> systems, whoever will be affected by this.

That may be an issue, as I'm guessing the biggest users of x86-32, is
probably small systems that uses Intel's attempts at the embedded space.

-- Steve
