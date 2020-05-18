From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Mon, 18 May 2020 06:41:26 -0700
Message-ID: <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
 <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
 <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0f751be6d25364c25ee4bddc425b61e626dcd942.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 5/15/20 7:53 PM, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
>> What's my recourse as an end user?  I want to run my app and turn off
>> CET for that app.  How can I do that?
> 
> GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT

Like I mentioned to H.J., this is something that we need to at least
acknowledge the existence of in the changelog and probably even the
Documentation/.

>>>>  I think you're saying that the CET-enabled binary would do
>>>> arch_setup_elf_property() when it was first exec()'d.  Later, it could
>>>> use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
>>>> then fork() and the child would not be using CET.  Right?
>>>>
>>>> What is ARCH_X86_CET_DISABLE used for, anyway?
>>>
>>> Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is
>>> not locked.
>>
>> Could you please describe a real-world example of why
>> ARCH_X86_CET_DISABLE exists?  What kinds of apps will use it, or *are*
>> using it?  Why was it created in the first place?
> 
> Currently, ld-linux turns off CET if the binary being loaded does not support
> CET.

Great!  Could this please be immortalized in the documentation for the
prctl()?

>>>>>> Does this *code* work?  Could you please indicate which JITs have been
>>>>>> enabled to use the code in this series?  How much of the new ABI is in use?
>>>>>
>>>>> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
>>>>> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
>>>>> are tested and in the master branch.  Sljit fixes are in the release.
>>>>
>>>> Huh, so who is using the new prctl() ABIs?
>>>
>>> Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
>>> new prctl()'s, except, probably to get CET status.
>>
>> Which applications specifically are going to use the new prctl()s which
>> this series adds?  How are they going to use them?
>>
>> "Any code can use them" is not a specific enough answer.
> 
> We have four arch_ptctl() calls.  ARCH_X86_CET_DISABLE and ARCH_X86_CET_LOCK are
> used by ld-linux.  ARCH_X86_CET_STATUS are used in many places to determine if
> CET is on.  ARCH_X86_CET_ALLOC_SHSTK is used in ucontext related handling, but
> it can be use by any application to switch shadow stacks.

Could some of this information be added to the documentation, please?
It would also be nice to have some more details about how apps end up
using ARCH_X86_CET_STATUS.  Why would they care that CET is on?
