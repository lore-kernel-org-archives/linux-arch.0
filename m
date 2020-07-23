From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Date: Thu, 23 Jul 2020 11:41:55 -0700
Message-ID: <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200723162531.GF21891@linux.intel.com>
 <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
 <20200723165649.GG21891@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200723165649.GG21891-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Christopherson <sean.j.christopherson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 7/23/20 9:56 AM, Sean Christopherson wrote:
> On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
>> On 7/23/20 9:25 AM, Sean Christopherson wrote:
>>> How would people feel about taking the above two patches (02 and 03 in the
>>> series) through the KVM tree to enable KVM virtualization of CET before the
>>> kernel itself gains CET support?  I.e. add the MSR and feature bits, along
>>> with the XSAVES context switching.  The feature definitons could use "" to
>>> suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
>>> to userspace.
>>>
>>> AIUI, there are ABI issues that need to be sorted out, and that is likely
>>> going to drag on for some time. 
>>>
>>> Is this a "hell no" sort of idea, or something that would be feasible if we
>>> can show that there are no negative impacts to the kernel?
>> Negative impacts like bloating every task->fpu with XSAVE state that
>> will never get used? ;)
> Gah, should have qualified that with "meaningful or measurable negative
> impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
> be acceptable overhead, but noticeably increasing the latency of XSAVES
> and/or XRSTORS would not be acceptable.

It's 40 bytes, but it's 40 bytes of just pure, unadulterated waste.  It
would have no *chance* of being used.  It's also quite precisely
measurable on a given system:

	cat /proc/slabinfo | grep task_struct | awk '{print $3 * 40}'

I don't expect it would do *much* to XSAVE/XRSTOR.  There's probably an
extra conditional and jump in the ucode, but that's probably in the
noise.  I assume that all the CET state has functioning init and
modified trackers and we don't do anything to spoil their state.  It
would be good to check that in practice, though it probably isn't the
end of the world either way.  We've had some bugs in the past where we
accidentally took things out of their init state.

It will make signal entry/return slower since we use a plain XSAVE
without the init optimization.  But, that's just a single cacheline on
average and some 0's to write.  Probably not noticeable, including the
40 bytes of extra userspace signal stack space.

I think that puts me in the "mildly annoyed" camp more than "hell no",
but "mildly annoyed" is pretty much my resting state, so it doesn't
really move the needle. :)

Why the urgency, though?

	https://windows-internals.com/cet-on-windows/

?
