From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 1/5] mm: untag user pointers in mmap/munmap/mremap/brk
Date: Fri, 23 Aug 2019 16:01:23 +0100
Message-ID: <20190823150123.okjow4g3mt2znz7c@willie-the-truck>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-2-catalin.marinas@arm.com>
 <20190819162851.tncj4wpwf625ofg6@willie-the-truck>
 <20190822164125.acfb97de912996b2b9127c61@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190822164125.acfb97de912996b2b9127c61@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Dave P Martin <Dave.Martin@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave Hansen <dave.hansen@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 22, 2019 at 04:41:25PM -0700, Andrew Morton wrote:
> On Mon, 19 Aug 2019 17:28:51 +0100 Will Deacon <will@kernel.org> wrote:
> 
> > On Thu, Aug 15, 2019 at 04:43:59PM +0100, Catalin Marinas wrote:
> > > There isn't a good reason to differentiate between the user address
> > > space layout modification syscalls and the other memory
> > > permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
> > > address ABI. Untag the user addresses on entry to these functions.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  mm/mmap.c   | 5 +++++
> > >  mm/mremap.c | 6 +-----
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Andrew -- please can you pick this patch up? I'll take the rest of the
> > series via arm64 once we've finished discussing the wording details.
> > 
> 
> Sure, I grabbed the patch from the v9 series.

Thanks, Andrew.

> But please feel free to include this in the arm64 tree - I'll autodrop
> my copy if this turns up in linux-next.

I'd prefer for this one to go via you so that it can sit with the rest of
the core changes relating to tagged addresses. Obviously please yell if
you run into any issues with it!

Cheers,

Will
