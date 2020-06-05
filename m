Return-Path: <SRS0=l6dP=7S=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:54068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFELrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 07:47:00 -0400
Date: Fri, 5 Jun 2020 12:46:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Message-ID: <20200605114654.GD31371@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-2-joro@8bytes.org>
 <20200605100813.GA31371@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605100813.GA31371@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>
Message-ID: <20200605114655.GJZJ9EUzsgVsVM3hMxjPTHqIyhglWEm34BqI_Ft7hMQ@z>

On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> This patch causes a kernel panic on arm64 (and possibly powerpc, I
> haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> checks for the empty p4d with pgd_none() instead of p4d_none().

Ah, should have checked the list first
(https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).

Please ignore my patch then.

-- 
Catalin
