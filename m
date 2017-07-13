From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 38/38] Documentation: PowerPC specific updates to memory
 protection keys
Date: Thu, 13 Jul 2017 12:56:19 -0700
Message-ID: <20170713195619.GJ5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
 <d0f1dc9b-7e10-3692-3922-abdbe4706428@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d0f1dc9b-7e10-3692-3922-abdbe4706428@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 11:23:29AM -0700, Dave Hansen wrote:
> On 07/05/2017 02:22 PM, Ram Pai wrote:
> > Add documentation updates that capture PowerPC specific changes.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  Documentation/vm/protection-keys.txt |   85 ++++++++++++++++++++++++++--------
> >  1 files changed, 65 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
> > index b643045..d50b6ab 100644
> > --- a/Documentation/vm/protection-keys.txt
> > +++ b/Documentation/vm/protection-keys.txt
> > @@ -1,21 +1,46 @@
> > -Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
> > -which will be found on future Intel CPUs.
> > +Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature found in
> > +new generation of intel CPUs and on PowerPC 7 and higher CPUs.
> 
> Please try not to change the wording here.  I really did mean to
> literally put "future Intel CPUs."  Also, you broke my nice wrapping. :)
> 
> I'm also thinking that this needs to be more generic.  The ppc _CPU_
> feature is *NOT* for userspace-only, right?

It can be used for protecting the kernel aswell with the help of the
hypervisor.  But the current implementation is towards "Protection keys
for Userspace" only; not yet "Protection keys for Kernel".  Hence will
not talk about it yet :). 

> 
> >  Memory Protection Keys provides a mechanism for enforcing page-based
> > -protections, but without requiring modification of the page tables
> > -when an application changes protection domains.  It works by
> > -dedicating 4 previously ignored bits in each page table entry to a
> > -"protection key", giving 16 possible keys.
> > -
> > -There is also a new user-accessible register (PKRU) with two separate
> > -bits (Access Disable and Write Disable) for each key.  Being a CPU
> > -register, PKRU is inherently thread-local, potentially giving each
> > -thread a different set of protections from every other thread.
> > -
> > -There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> > -to the new register.  The feature is only available in 64-bit mode,
> > -even though there is theoretically space in the PAE PTEs.  These
> > -permissions are enforced on data access only and have no effect on
> > +protections, but without requiring modification of the page tables when an
> > +application changes protection domains.
> > +
> > +
> > +On Intel:
> > +
> > +	It works by dedicating 4 previously ignored bits in each page table
> > +	entry to a "protection key", giving 16 possible keys.
> > +
> > +	There is also a new user-accessible register (PKRU) with two separate
> > +	bits (Access Disable and Write Disable) for each key.  Being a CPU
> > +	register, PKRU is inherently thread-local, potentially giving each
> > +	thread a different set of protections from every other thread.
> > +
> > +	There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> > +	to the new register.  The feature is only available in 64-bit mode,
> > +	even though there is theoretically space in the PAE PTEs.  These
> > +	permissions are enforced on data access only and have no effect on
> > +	instruction fetches.
> > +
> > +
> > +On PowerPC:
> > +
> > +	It works by dedicating 5 page table entry bits to a "protection key",
> > +	giving 32 possible keys.
> > +
> > +	There  is  a  user-accessible  register (AMR)  with  two separate bits;
> > +	Access Disable and  Write  Disable, for  each key.  Being  a  CPU
> > +	register,  AMR  is inherently  thread-local,  potentially  giving  each
> > +	thread a different set of protections from every other thread.  NOTE:
> > +	Disabling read permission does not disable write and vice-versa.
> > +
> > +	The feature is available on 64-bit HPTE mode only.
> > +	'mtspr 0xd, mem' reads the AMR register
> > +	'mfspr mem, 0xd' writes into the AMR register.
> 
> The whole "being a CPU register" bits seem pretty common.  Should it be
> in the leading paragraph that is shared?
> 
> > +Permissions are enforced on data access only and have no effect on
> >  instruction fetches.
> 
> Shouldn't we mention the ppc support for execute-disable here too?

yes. have reformated the structure to capture all that information. Will
be in my v6 patch version.

> 
> Also, *does* this apply to ppc?  You have it both in this common area
> and in the x86 portion.
> 
> >  =========================== Syscalls ===========================
> > @@ -28,9 +53,9 @@ There are 3 system calls which directly interact with pkeys:
> >  			  unsigned long prot, int pkey);
> >  
> >  Before a pkey can be used, it must first be allocated with
> > -pkey_alloc().  An application calls the WRPKRU instruction
> > +pkey_alloc().  An application calls the WRPKRU/AMR instruction
> >  directly in order to change access permissions to memory covered
> > -with a key.  In this example WRPKRU is wrapped by a C function
> > +with a key.  In this example WRPKRU/AMR is wrapped by a C function
> >  called pkey_set().
> >  
> >  	int real_prot = PROT_READ|PROT_WRITE;
> > @@ -52,11 +77,11 @@ is no longer in use:
> >  	munmap(ptr, PAGE_SIZE);
> >  	pkey_free(pkey);
> >  
> > -(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
> > +(Note: pkey_set() is a wrapper for the RDPKRU,WRPKRU or AMR instructions.
> >   An example implementation can be found in
> >   tools/testing/selftests/x86/protection_keys.c)
> >  
> > -=========================== Behavior ===========================
> > +=========================== Behavior =================================
> >  
> >  The kernel attempts to make protection keys consistent with the
> >  behavior of a plain mprotect().  For instance if you do this:
> > @@ -83,3 +108,23 @@ with a read():
> >  The kernel will send a SIGSEGV in both cases, but si_code will be set
> >  to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
> >  the plain mprotect() permissions are violated.
> > +
> > +
> > +====================================================================
> > +		Semantic differences
> > +
> > +The following semantic differences exist between x86 and power.
> > +
> > +a) powerpc allows creation of a key with execute-disabled.  The following
> > +	is allowed on powerpc.
> > +	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_ACCESS |
> > +			PKEY_DISABLE_EXECUTE);
> > +   x86 disallows PKEY_DISABLE_EXECUTE during key creation.
> 
> It isn't that powerpc supports *creation* of the key.  It doesn't
> support setting PKEY_DISABLE_EXECUTE, period, which implies that you
> can't set it at pkey_alloc().  That's a pretty important distinction, IMNHO.

ok. will the following wording capture the subtle distinction?

+a) powerpc *also* allows creation of a key with execute-disabled.
+	The following is allowed on powerpc.
+	pkey = pkey_alloc(0, PKEY_DISABLE_EXECUTE);
+
+b) ....

> 
> > +b) changing the permission bits of a key from a signal handler does not
> > +   persist on x86. The PKRU specific fpregs entry needs to be modified
> > +   for it to persist.  On powerpc the permission bits of the key can be
> > +   modified by programming the AMR register from the signal handler.
> > +   The changes persists across signal boundaries.
> 
> ^"changes persist", not "persists".

done.

-- 
Ram Pai
