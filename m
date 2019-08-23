From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v9 3/3] arm64: Relax
 Documentation/arm64/tagged-pointers.rst
Date: Fri, 23 Aug 2019 17:32:49 +0100
Message-ID: <20190823163247.GG27757@arm.com>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-4-catalin.marinas@arm.com>
 <20190821173352.yqfgaozi7nfhcofg@willie-the-truck>
 <20190821184649.GD27757@arm.com>
 <20190822155531.GB55798@arrakis.emea.arm.com>
 <20190822163723.GF27757@arm.com>
 <20190823161912.GJ29387@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190823161912.GJ29387@arrakis.emea.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave Hansen <dave.hansen@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 23, 2019 at 05:19:13PM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2019 at 05:37:23PM +0100, Dave P Martin wrote:
> > On Thu, Aug 22, 2019 at 04:55:32PM +0100, Catalin Marinas wrote:
> > > On Wed, Aug 21, 2019 at 07:46:51PM +0100, Dave P Martin wrote:

[...]

> > > > sigaltstack() is interesting, since we don't support tagged stacks.
> > > 
> > > We should support tagged SP with the new ABI as they'll be required for
> > > MTE. sigaltstack() and clone() are the two syscalls that come to mind
> > > here.
> > > 
> > > > Do we keep the ss_sp tag in the kernel, but squash it when delivering
> > > > a signal to the alternate stack?
> > > 
> > > We don't seem to be doing any untagging, so we just just use whatever
> > > the caller asked for. We may need a small test to confirm.
> > 
> > If we want to support tagged SP, then I guess we shouldn't be squashing
> > the tag anywhere.  A test for that would be sensible to have.
> 
> I hacked the sas.c kselftest to use a tagged stack and works fine, the
> SP register has a tagged address on the signal handler.

Cool...

[...]

> > > > There is no foolproof rule, unless we can rewrite history...
> > > 
> > > I would expect the norm to be the preservation of tags with a few
> > > exceptions. The only ones I think where we won't preserve the tags are
> > > mmap, mremap, brk (apart from the signal stuff already mentioned in the
> > > current tagged-pointers.rst doc).
> > > 
> > > So I can remove this paragraph altogether and add a note in part 3 of
> > > the tagged-address-abi.rst document that mmap/mremap/brk do not preserve
> > > the tag information.
> > 
> > Deleting text is always a good idea ;)
> 
> I'm going this route ;).

[reply deleted]

Cheers
---Dave
