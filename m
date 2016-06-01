From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 00/15] Provide atomics and bitops implemented with
 ISO C++11 atomics
Date: Wed, 1 Jun 2016 15:45:45 +0100
Message-ID: <20160601144545.GG355@arm.com>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Hi David,

On Wed, May 18, 2016 at 04:10:37PM +0100, David Howells wrote:
> 
> Here's a set of patches to provide kernel atomics and bitops implemented
> with ISO C++11 atomic intrinsics.  The second part of the set makes the x86
> arch use the implementation.

As you know, I'm really not a big fan of this :)

Whilst you're seeing some advantages in using this on x86, I suspect
that's because the vast majority of memory models out there end up using
similar instructions sequences on that architecture (i.e. MOV and a very
occasional mfence). For weakly ordered architectures such as arm64, the
kernel memory model is noticeably different to that offered by C11 and
I'd be hesitant to map the two as you're proposing here, for the following
reasons:

  (1) C11's SC RMW operations are weaker than our full barrier atomics

  (2) There is no high quality implementation of consume loads, so we'd
      either need to continue using our existing rcu_deference code or
      be forced to use acquire loads

  (3) wmb/rmb don't exist in C11

  (4) We patch our atomics at runtime based on the CPU capabilites, since
      we require a single binary kernel Image

  (5) Even recent versions of GCC have been found to have serious issues
      generating correct (let alone performant) code [1]

  (6) If we start mixing and patching C11 atomics with homebrew atomics
      in an attempt to address some of the issues above, we open ourselves
      up to potential data races (i.e. undefined behaviour), but I doubt
      existing compilers actually manage to detect this.

Now, given all of that, you might be surprised to hear that I'm not
completely against some usage of C11 atomics in the kernel! What I think
would work quite nicely is defining an asm-generic interface built solely
out of the C11 _relaxed atomics and SC fences. Would it be efficient? Almost
certainly not. Would it be useful for new architecture ports to get up and
running quickly? Definitely.

In my opinion, if an architecture wants to go further than that (like you've
proposed here), then the code should be entirely confined to the relevant
arch/ directory and not advertised as a general, portable mapping between
the memory models.

Will

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69875
