From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Date: Mon, 13 Apr 2020 06:34:44 -0700
Message-ID: <20200413133444.GM21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-2-npiggin@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 13, 2020 at 10:53:00PM +1000, Nicholas Piggin wrote:
> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
> 
> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.

I'm trying to get us away from returning tail pages from various
functions.  How much of a pain would it be to return the head page
instead of the tail page?  Obviously the implementation gets simpler,
but can the callers cope?  I've been focusing on the page cache, so I
haven't been looking at the vmalloc side of things at all.
