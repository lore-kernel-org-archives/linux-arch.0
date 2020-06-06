From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Date: Sat, 6 Jun 2020 13:50:22 +0100
Message-ID: <20200606125021.GA12556@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-2-joro@8bytes.org>
 <20200605100813.GA31371@gaia>
 <20200605114654.GD31371@gaia>
 <20200605180116.196116ea218df55f3252af57@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:36658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgFFMu1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jun 2020 08:50:27 -0400
Content-Disposition: inline
In-Reply-To: <20200605180116.196116ea218df55f3252af57@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>

On Fri, Jun 05, 2020 at 06:01:16PM -0700, Andrew Morton wrote:
> On Fri, 5 Jun 2020 12:46:55 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> > > This patch causes a kernel panic on arm64 (and possibly powerpc, I
> > > haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> > > checks for the empty p4d with pgd_none() instead of p4d_none().
> > 
> > Ah, should have checked the list first
> > (https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).
> 
> Can you confirm that the merge of Mike's 5level_hack zappage has fixed
> the arm64 wontboot?

Yes, it has. Mainline is booting again on arm64.

Thanks.

-- 
Catalin
