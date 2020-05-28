From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and
 mprotect()
Date: Thu, 28 May 2020 12:05:09 +0100
Message-ID: <20200528110509.GA18623@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com>
 <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
 <20200528091445.GA2961@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200528091445.GA2961@gaia>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, nd@arm.com, Peter Collingbourne <pcc@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Evgenii Stepanov <eugenis@google.com>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

The 05/28/2020 10:14, Catalin Marinas wrote:
> On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> > On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > To enable tagging on a memory range, the user must explicitly opt in via
> > > a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> > > memory type in the AttrIndx field of a pte, simplify the or'ing of these
> > > bits over the protection_map[] attributes by making MT_NORMAL index 0.
> > 
> > Should the userspace stack always be mapped as if with PROT_MTE if the
> > hardware supports it? Such a change would be invisible to non-MTE
> > aware userspace since it would already need to opt in to tag checking
> > via prctl. This would let userspace avoid a complex stack
> > initialization sequence when running with stack tagging enabled on the
> > main thread.
> 
> I don't think the stack initialisation is that difficult. On program
> startup (can be the dynamic loader). Something like (untested):
> 
> 	register unsigned long stack asm ("sp");
> 	unsigned long page_sz = sysconf(_SC_PAGESIZE);
> 
> 	mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
> 		 PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);
> 
> (the essential part it PROT_GROWSDOWN so that you don't have to specify
> a stack lower limit)

does this work even if the currently mapped stack is more than page_sz?
determining the mapped main stack area is i think non-trivial to do in
userspace (requires parsing /proc/self/maps or similar).

...
> I'm fine, however, with enabling PROT_MTE on the main stack based on
> some ELF note.

note that would likely mean an elf note on the dynamic linker
(because a dynamic linked executable may not be loaded by the
kernel and ctors in loaded libs run before the executable entry
code anyway, so the executable alone cannot be in charge of this
decision) i.e. one global switch for all dynamic linked binaries.

i think a dynamic linker can map a new stack and switch to it
if it needs to control the properties of the stack at runtime
(it's wasteful though).

and i think there should be a runtime mechanism for the brk area:
it should be possible to request that future brk expansions are
mapped as PROT_MTE so an mte aware malloc implementation can use
brk. i think this is not important in the initial design, but if
a prctl flag can do it that may be useful to add (may be at a
later time).

(and eventually there should be a way to use PROT_MTE on
writable global data and appropriate code generation that
takes colors into account when globals are accessed, but
that requires significant ELF, ld.so and compiler changes,
that need not be part of the initial mte design).
