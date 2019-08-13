From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Tue, 13 Aug 2019 12:10:04 +0100
Message-ID: <20190813111004.GV10425@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
 <20190808172730.GC37129@arrakis.emea.arm.com>
 <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
 <20190812173611.GD62772@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190812173611.GD62772@arrakis.emea.arm.com>
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
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 12, 2019 at 06:36:12PM +0100, Catalin Marinas wrote:
> On Fri, Aug 09, 2019 at 07:10:18AM -0700, Dave Hansen wrote:
> > On 8/8/19 10:27 AM, Catalin Marinas wrote:
> > > On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:
> > >> Also, shouldn't this be converted over to an arch_prctl()?
> > > 
> > > What do you mean by arch_prctl()? We don't have such thing, apart from
> > > maybe arch_prctl_spec_ctrl_*(). We achieve the same thing with the
> > > {SET,GET}_TAGGED_ADDR_CTRL macros. They could be renamed to
> > > arch_prctl_tagged_addr_{set,get} or something but I don't see much
> > > point.
> > 
> > Silly me.  We have an x86-specific:
> > 
> > 	SYSCALL_DEFINE2(arch_prctl, int , option, unsigned long , arg2)
> > 
> > I guess there's no ARM equivalent so you're stuck with the generic one.
> > 
> > > What would be better (for a separate patch series) is to clean up
> > > sys_prctl() and move the arch-specific options into separate
> > > arch_prctl() under arch/*/kernel/. But it's not really for this series.
> > 
> > I think it does make sense for truly arch-specific features to stay out
> > of the arch-generic prctl().  Yes, I know I've personally violated this
> > in the past. :)
> 
> Maybe Dave M could revive his prctl() clean-up patches which moves the
> arch specific cases to the corresponding arch/*/ code

I'll try to take a look at it.

> > >> What is the scope of these prctl()'s?  Are they thread-scoped or
> > >> process-scoped?  Can two threads in the same process run with different
> > >> tagging ABI modes?
> > > 
> > > Good point. They are thread-scoped and this should be made clear in the
> > > doc. Two threads can have different modes.
> > > 
> > > The expectation is that this is invoked early during process start (by
> > > the dynamic loader or libc init) while in single-thread mode and
> > > subsequent threads will inherit the same mode. However, other uses are
> > > possible.
> > 
> > If that's the expectation, it would be really nice to codify it.
> > Basically, you can't enable the feature if another thread is already
> > been forked off.
> 
> Well, that's my expectation but I'm not a userspace developer. I don't
> think there is any good reason to prevent it. It doesn't cost us
> anything to support in the kernel, other than making the documentation
> clearer.

This came up for SVE and eventually we didn't bother, partly because the
kernel doesn't fully know what userspace is trying to do, in general.

If userspace has some kind of worker threads that run specific code,
they could legitimately interface differently with the kernel compared
with, say, the main thread.  This model already exists for e.g.,
seccomp.

In any case, I think it's not up to the kernel to dictate how user
runtimes initialise themselves.

[...]

Cheers
---Dave
