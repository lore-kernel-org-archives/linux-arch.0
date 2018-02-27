From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
Date: Mon, 26 Feb 2018 20:19:35 -0600
Message-ID: <87r2p7uqbs.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-4-ebiederm@xmission.com>
        <20180112222944.GA22642@ls3530.fritz.box>
        <87fu5s4l4b.fsf@xmission.com>
        <68641c9e-99c6-34d3-83aa-1241bddef33c@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68641c9e-99c6-34d3-83aa-1241bddef33c@gmx.de> (Helge Deller's
        message of "Sun, 25 Feb 2018 20:49:41 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> On 23.02.2018 01:15, Eric W. Biederman wrote:
>> Helge Deller <deller@gmx.de> writes:
>> 
>>> * Eric W. Biederman <ebiederm@xmission.com>:
>>>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>>>> This is the same si_code as SI_USER.  Posix and common sense requires
>>>> that SI_USER not be a signal specific si_code.  As such this use of 0
>>>> for the si_code is a pretty horribly broken ABI.
>>>>
>>>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>>>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>>>> that uid and pid fields are copied and which might copying the si_addr
>>>> field by accident but certainly not by design.  Making this a very
>>>> flakey implementation.
>>>>
>>>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>>>> appropriate fields will reliably be copied.
>>>>
>>>> This bug is 13 years old and parsic machines are no longer being built
>>>> so I don't know if it possible or worth fixing it.  But it is at least
>>>> worth documenting this so other architectures don't make the same
>>>> mistake.
>>>
>>>
>>> I think we should fix it, even if we now break the ABI.
>>>
>>> It's about a "conditional trap" which needs to be handled by userspace.
>>> I doubt there is any Linux code out which is utilizing this
>>> parisc-specific trap.
>>>
>>> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
>>> While at it, maybe we should include the already existing FPE_MDAOVF
>>> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
>>> can go completely.
>>>
>>> Suggested patch is below.
>>>
>>> I'm willing to test the patch below on the parisc architecture for a few
>>> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
>>> looking at then too.
>> 
>> Have you managed to test this change?
>
> Sadly I haven't done any further testing yet.

So at this point for purposed of testing I don't think it matters which
number FPE_CONDTRAP gets as long as it is non-zero.
>  
>> I am sitting looking at another new FPE si_code and if this has been tested
>> I figure FPE_CONDTRAP should get the next available FPE si_code and the
>> other change should get the one that follows.
>
> I'm fine either way. Do you have a git tree I can pull which includes
> all your patches? I can then start testing.

Everything finalized is in Linus's tree.  There is a patch pending
review on linux-arch that defines FPE_FLTUNK that looks to be useful
on several architectures.

I had probably misread our earlier exchange.  I had hoped you had tested
that FPE_CONDTRAP did not cause problems.

If that level of testing was complete I would have given FPE_CONDTRAP
the next FPE number and FPE_FLTUNK the one after.

As it sounds like FPE_CONDTRAP hasn't been tested enough to know if it
causes problems I will encourage the patches to be merged in the other
order.

Eric
