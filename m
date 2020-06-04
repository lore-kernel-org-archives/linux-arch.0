From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Fix pud_alloc_track()
Date: Thu, 4 Jun 2020 13:36:22 -0700
Message-ID: <20200604133622.c23b365066af0b14a9f04961@linux-foundation.org>
References: <20200604074446.23944-1-joro@8bytes.org>
        <20200604164814.GA7600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200604164814.GA7600@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, peterz@infradead.org, jroedel@suse.de, Andy Lutomirski <luto@kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Jun 2020 19:48:14 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Thu, Jun 04, 2020 at 09:44:46AM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The pud_alloc_track() needs to do different checks based on whether
> > __ARCH_HAS_5LEVEL_HACK is defined, like it already does in
> > pud_alloc(). Otherwise it causes boot failures on PowerPC.
> > 
> > Provide the correct implementations for both possible settings of
> > __ARCH_HAS_5LEVEL_HACK to fix the boot problems.
> 
> There is a patch in mmotm [1] that completely removes
> __ARCH_HAS_5LEVEL_HACK which is a part of the series [2] that updates
> p4d folding accross architectures. This should fix boot on PowerPC and
> the addition of pXd_alloc_track() for __ARCH_HAS_5LEVEL_HACK wouldn't be
> necessary.
> 
> 
> [1] https://github.com/hnaz/linux-mm/commit/cfae68792af3731ac902ea6ba5ed8df5a0f6bd2f
> [2] https://lore.kernel.org/kvmarm/20200414153455.21744-1-rppt@kernel.org/

That patchset is stacked up behind many other patches, including all
the powerpc stuff in linux-next :(

As it's a big bug fix, I'll pull those patches forward, hopefully send it
all Linuswards later today...
