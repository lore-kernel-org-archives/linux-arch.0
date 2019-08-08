From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 17:27:02 +0100
Message-ID: <20190808162702.GJ10425@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:

[Random comments below on a couple of points]

> On 8/7/19 8:53 AM, Catalin Marinas wrote:
> > +- mmap() done by the process itself (or its parent), where either:
> > +
> > +  - flags have the **MAP_ANONYMOUS** bit set
> > +  - the file descriptor refers to a regular file (including those returned
> > +    by memfd_create()) or **/dev/zero**
> 
> What's a "regular file"? ;)

A file, as distinct from device nodes, sockets, symlinks etc.

I think this is fairly standard UNIX terminology, even though it sounds
vague:

From glibc's <bits/stat.h>:

#define	__S_IFREG	0100000	/* Regular file.  */


Or for POSIX test (a.k.a. "[")

       -f file
              True if file exists and is a regular file.

Using memfd_create() or opening /dev/zero doesn't yield a regular file
though, so perhaps those should be a separate bullet.

[...]

> > +The AArch64 Tagged Address ABI is an opt-in feature and an application can
> > +control it via **prctl()** as follows:
> > +
> > +- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
> > +  ABI for the calling process.
> > +
> > +  The (unsigned int) arg2 argument is a bit mask describing the control mode
> > +  used:
> > +
> > +  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
> > +    status is disabled.
> > +
> > +  The arguments arg3, arg4, and arg5 are ignored.
> 
> For previous prctl()'s, we've found that it's best to require that the
> unused arguments be 0.  Without that, apps are free to put garbage
> there, which makes extending the prctl to use other arguments impossible
> in the future.

Because arg2 is already a mask of flags with some flags unallocated,
we can add a new flag for ABI extensions.

If arg3 is used someday, it may or may not be natural for 0 to mean
"default".  Enabling this argument with an explicit flag in arg2 may
be cleaner than mangling the semantics of arg3 so that 0 can have
the right meaning.

Avoiding redundant 0 arguments also allows userspace to take advantage
of the glibc's variadic prototype for prctl() for example.

Not a huge deal, but that was my rationale anyway.

> Also, shouldn't this be converted over to an arch_prctl()?

Most arch-specific prctls seem to use prctl(), and arm64 already has a
few there.

arch_prctl() is x86-specific.  I don't know the history.

[...]

Cheers
---Dave
