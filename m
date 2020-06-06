From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Date: Fri, 5 Jun 2020 18:01:16 -0700
Message-ID: <20200605180116.196116ea218df55f3252af57@linux-foundation.org>
References: <20200515140023.25469-1-joro@8bytes.org>
        <20200515140023.25469-2-joro@8bytes.org>
        <20200605100813.GA31371@gaia>
        <20200605114654.GD31371@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200605114654.GD31371@gaia>
Sender: linux-acpi-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 5 Jun 2020 12:46:55 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> > This patch causes a kernel panic on arm64 (and possibly powerpc, I
> > haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> > checks for the empty p4d with pgd_none() instead of p4d_none().
> 
> Ah, should have checked the list first
> (https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).
> 

Sorry about that.

Can you confirm that the merge of Mike's 5level_hack zappage has fixed
the arm64 wontboot?
