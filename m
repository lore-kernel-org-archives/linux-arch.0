From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 16/19] linux/compiler.h: Split into compiler.h and
 compiler-types.h
Date: Tue, 24 Oct 2017 10:30:26 +0100
Message-ID: <20171024093026.GB17909@arm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
 <1508792849-3115-16-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171024092512.nwumnxqrpaols55g@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024092512.nwumnxqrpaols55g@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 24, 2017 at 11:25:12AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > linux/compiler.h is included indirectly by linux/types.h via
> > uapi/linux/types.h -> uapi/linux/posix_types.h -> linux/stddef.h
> > -> uapi/linux/stddef.h and is needed to provide a proper definition of
> > offsetof.
> > 
> > Unfortunately, compiler.h requires a definition of
> > smp_read_barrier_depends() for defining lockless_dereference and soon
> > for defining READ_ONCE, which means that all
> > users of READ_ONCE will need to include asm/barrier.h to avoid splats
> > such as:
> > 
> >    In file included from include/uapi/linux/stddef.h:1:0,
> >                     from include/linux/stddef.h:4,
> >                     from arch/h8300/kernel/asm-offsets.c:11:
> >    include/linux/list.h: In function 'list_empty':
> > >> include/linux/compiler.h:343:2: error: implicit declaration of function 'smp_read_barrier_depends' [-Werror=implicit-function-declaration]
> >      smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
> >      ^
> > 
> > A better alternative is to include asm/barrier.h in linux/compiler.h,
> > but this requires a type definition for "bool" on some architectures
> > (e.g. x86), which is defined later by linux/types.h. Type "bool" is also
> > used directly in linux/compiler.h, so the whole thing is pretty fragile.
> > 
> > This patch splits compiler.h in two: compiler-types.h contains type
> > annotations, definitions and the compiler-specific parts, whereas
> > compiler.h #includes compiler-types.h and additionally defines macros
> > such as {READ,WRITE.ACCESS}_ONCE.
> > 
> > uapi/linux/stddef.h and linux/linkage.h are then moved over to include
> > linux/compiler-types.h, which fixes the build for h8 and blackfin.
> > 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > [ paulmck: Add Will's fixes for issues reported by kbuild test robot. ]
> > ---
> >  arch/arm/include/asm/ptrace.h   |   3 +-
> >  arch/sparc/include/asm/ptrace.h |   1 +
> >  arch/um/include/shared/init.h   |   2 +-
> >  include/linux/compiler-clang.h  |   2 +-
> >  include/linux/compiler-gcc.h    |   2 +-
> >  include/linux/compiler-intel.h  |   2 +-
> >  include/linux/compiler-types.h  | 274 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/compiler.h        | 265 +-------------------------------------
> 
> The common pattern is to use an underscore (compiler_types.h), not a hyphen 
> (compiler-types.h) ...

I just followed the existing examples of compiler-{clang,gcc,intel}.h!
I can respin if you like, but it will be inconsistent with the existing
compiler* headers and it's not like there aren't other hyphenated header
files in include/linux/ (I count 433).

Will
