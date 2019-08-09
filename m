Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:7130 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIOKU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Aug 2019 10:10:20 -0400
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
 <20190808172730.GC37129@arrakis.emea.arm.com>
Message-ID: <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
Date: Fri, 9 Aug 2019 07:10:18 -0700
MIME-Version: 1.0
In-Reply-To: <20190808172730.GC37129@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190809141018.2EzXxTEEAkUoNYKy-GQJyZxrFfiipzpdvNrUpnO0oYY@z>

On 8/8/19 10:27 AM, Catalin Marinas wrote:
> On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:
> Extending the interface is still possible even with the current
> proposal, by changing arg2 etc. We also don't seem to be consistent in
> sys_prctl().

We are not consistent because it took a long time to learn this lesson,
but I think this is a best-practice that we follow for new ones.

>> Also, shouldn't this be converted over to an arch_prctl()?
> 
> What do you mean by arch_prctl()? We don't have such thing, apart from
> maybe arch_prctl_spec_ctrl_*(). We achieve the same thing with the
> {SET,GET}_TAGGED_ADDR_CTRL macros. They could be renamed to
> arch_prctl_tagged_addr_{set,get} or something but I don't see much
> point.

Silly me.  We have an x86-specific:

	SYSCALL_DEFINE2(arch_prctl, int , option, unsigned long , arg2)

I guess there's no ARM equivalent so you're stuck with the generic one.

> What would be better (for a separate patch series) is to clean up
> sys_prctl() and move the arch-specific options into separate
> arch_prctl() under arch/*/kernel/. But it's not really for this series.

I think it does make sense for truly arch-specific features to stay out
of the arch-generic prctl().  Yes, I know I've personally violated this
in the past. :)

>> What is the scope of these prctl()'s?  Are they thread-scoped or
>> process-scoped?  Can two threads in the same process run with different
>> tagging ABI modes?
> 
> Good point. They are thread-scoped and this should be made clear in the
> doc. Two threads can have different modes.
> 
> The expectation is that this is invoked early during process start (by
> the dynamic loader or libc init) while in single-thread mode and
> subsequent threads will inherit the same mode. However, other uses are
> possible.

If that's the expectation, it would be really nice to codify it.
Basically, you can't enable the feature if another thread is already
been forked off.

> That said, do we have a precedent for changing user ABI from the kernel
> cmd line? 'noexec32', 'vsyscall' I think come close. With the prctl()
> for opt-in, controlling this from the cmd line is not too bad (though my
> preference is still for the sysctl).

There are certainly user-visible things like being able to select
various CPU features.

>>> +When a process has successfully enabled the new ABI by invoking
>>> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
>>> +behaviours are guaranteed:
>>> +
>>> +- Every currently available syscall, except the cases mentioned in section
>>> +  3, can accept any valid tagged pointer. The same rule is applicable to
>>> +  any syscall introduced in the future.
>>> +
>>> +- The syscall behaviour is undefined for non valid tagged pointers.
>>
>> Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
>>  Why should it matter if it's a tagged bad pointer or an untagged bad
>> pointer?
> 
> Szabolcs already replied here. We may have tagged pointers that can be
> dereferenced just fine but being passed to the kernel may not be well
> defined (e.g. some driver doing a find_vma() that fails unless it
> explicitly untags the address). It's as undefined as the current
> behaviour (without these patches) guarantees.

It might just be nicer to point out what this features *changes* about
invalid pointer handling, which is nothing. :)  Maybe:

	The syscall behaviour for invalid pointers is the same for both
	tagged and untagged pointers.

>>> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
>>> +  PR_SET_MM_MAP_SIZE.
>>> +
>>> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
>>> +
>>> +Any attempt to use non-zero tagged pointers will lead to undefined
>>> +behaviour.
>>
>> I wonder if you want to generalize this a bit.  I think you're saying
>> that parts of the ABI that modify the *layout* of the address space
>> never accept tagged pointers.
> 
> I guess our difficulty in specifying this may have been caused by
> over-generalising. For example, madvise/mprotect came under the same
> category but there is a use-case for malloc'ed pointers (and tagged) to
> the kernel (e.g. MADV_DONTNEED). If we can restrict the meaning to
> address space *layout* manipulation, we'd have mmap/mremap/munmap,
> brk/sbrk, prctl(PR_SET_MM). Did I miss anything?. Other related syscalls
> like mprotect/madvise preserve the layout while only changing permissions,
> backing store, so the would be allowed to accept tags.

shmat() comes to mind.  I also did a quick grep for mmap_sem taken for
write and didn't see anything else obvious jump out at me.

>> It looks like the TAG_SHIFT and tag size are pretty baked into the
>> aarch64 architecture.  But, are you confident that no future
>> implementations will want different positions or sizes?  (obviously
>> controlled by other TCR_EL1 bits)
> 
> For the top-byte-ignore (TBI), that's been baked in the architecture
> since ARMv8.0 and we'll have to keep the backwards compatible mode. As
> the name implies, it's the top byte of the address and that's what the
> document above refers to.
> 
> With MTE, I can't exclude other configurations in the future but I'd
> expect the kernel to present the option as a new HWCAP and the user to
> explicitly opt in via a new prctl() flag. I seriously doubt we'd break
> existing binaries. So, yes TAG_SHIFT may be different but so would the
> prctl() above.

Basically, what you have is a "turn tagging on" and "turn tagging off"
call which are binary: all on or all off.  How about exposing a mask:

	/* Replace hard-coded mask size/position: */
	unsigned long mask = prctl(GET_POSSIBLE_TAGGED_ADDR_BITS);

	if (mask == 0)
		// no tagging is supported obviously

	prctl(SET_TAGGED_ADDR_BITS, mask);

	// now userspace knows via 'mask' where the tag bits are
