From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Date: Wed, 13 May 2020 13:01:12 +0200
Message-ID: <a01fc572-cac8-1932-c3e5-c70184417ca3@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
 <20200513084351.GB18196@willie-the-truck> <20200513104635.GD21779@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgEMLBP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:01:15 -0400
In-Reply-To: <20200513104635.GD21779@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, Will Deacon <will@kernel.org>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>

Hi,

On 5/13/20 12:46 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 09:43:52AM +0100, Will Deacon wrote:
>> Hi Dave,
>>
>> On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:
>>> diff --git a/man2/prctl.2 b/man2/prctl.2
>>> index 7f511d2..dd16227 100644
>>> --- a/man2/prctl.2
>>> +++ b/man2/prctl.2
>>> @@ -1291,6 +1291,104 @@ call failing with the error
>>>  .BR ENXIO .
>>>  For further details, see the kernel source file
>>>  .IR Documentation/admin-guide/kernel-parameters.txt .
>>> +.\" prctl PR_SVE_SET_VL
>>> +.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
>>> +.\" linux-5.6/Documentation/arm64/sve.rst
>>> +.TP
>>> +.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
>>> +Configure the thread's SVE vector length,
>>> +as specified by
>>> +.IR arg2 .
>>> +Arguments
>>> +.IR arg3 ", " arg4 " and " arg5
>>> +are ignored.
>>
>> Bugger, did we forget to force these to zero? I guess we should write the
>> man-page first next time :(

Quite...

> Not an accident, but there does seem to be some inconsistency in policy
> among the various prctls here.

The whole 5-args-for-prctl thing was a bit of a misdesign.

The general preference is that, for new prctls, unused arguments 
should be required to be zero. Historically, there was much
inconsistency.

> glibc explicitly has
> 
> 	extern int prctl (int __option, ...);
> 
> (and nobody has to write _exit(0, 0, 0, 0, 0, 0) after all.)
> 
> Is there some agreed rationale for requiring redundant arguments to be
> supplied explicitly as zero?  For now there are likely to be few users
> of this, so we _might_ get away with changing the behaviour here if it's
> considered important enough.

See above.

> There is no forwards compatibility problem with this prctl though,
> because there are spare bits in arg2 which can "turn on" additional
> args if needed.
> 
> Also, it's implausible that PR_SVE_GET_VL will ever want an argument.
> 
> There are still 2 billion unallocated prctl numbers, so new prctls can
> always be added if there's ever a need to work around these limitations,
> but it seems extremely unlikely.
> 
>>
>>> +.IP
>>> +The bits of
>>> +.I arg2
>>> +corresponding to
>>> +.B SVE_VL_LEN_MASK
>>
>> PR_SVE_LEN_MASK
> 
> Hmm, not sure how that happened.  Good spot!
> 
> I'll recheck that all the names are real when reposting.
> 
>>> +must be set to the desired vector length in bytes.
>>> +In addition,
>>> +.I arg2
>>> +may include zero or more of the following flags:
>>> +.RS
>>> +.TP
>>> +.B PR_SVE_VL_INHERIT
>>> +Inherit the configured vector length across
>>> +.BR execve (2).
>>> +.TP
>>> +.B PR_SVE_SET_VL_ONEXEC
>>> +Defer the change until the next
>>> +.BR execve (2)
>>> +in this thread.
>>
>> (aside, it's weird that we didn't allocate (1<<16) for one of these flags)
> 
> The flag definitions are shared with ptrace: ptrace is the
> SVE_PT_REGS_SVE format selection bit, which isn't relevant to the prctl.
> 
> Maybe it would have made more sense to keep the definitions completely
> separate, but it's there now.
> 
>>> +If
>>> +.B PR_SVE_VL_INHERIT
>>> +is also included in
>>> +.IR arg2 ,
>>> +it takes effect
>>> +.I after
>>> +this deferred change.
>>
>> I find this a bit hard to follow, since it's not clear to me whether the
>> INHERIT flag is effectively set before or after the next execve(). In other
>> words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
>> is the vector length preserved or reset on the next execve()?
> 
> It makes no difference, because the ONEXEC handling takes priority over
> the INHERIT handling. But either way INHERIT is never cleared by execve()
> and will apply at subsequent execs().
> 
> Explaining all this properly seems out of scope here.  Maybe this should
> be trimmed down rather than elaborated?  Or perhaps just explain it in
> terms of what the kernel does instead of futile attempts to make it
> intuitive?
> 
> Ultimately I'll probably write a separate page or pages for SVE and other
> arm64 specifics.

(okay.)

>>> +.RE
>>> +.IP
>>> +On success, the vector length and flags are set as requested,
>>> +and any deferred change that was pending immediately before the
>>> +.B PR_SVE_SET_VL
>>> +call is canceled.
>>
>> Huh, turns out 'canceled' is a valid US spelling. Fair enough, but it looks
>> wrong to me ;)
> 
> Yeah, I know, but the man pages do have a documented policy on this...
> 
> prctl.2 has a lot of authors, so having mixed spellings could get
> particularly messy.

Quite. Indeed, that was how things were when I took over as
maintainer: a hodge-podge of British and American spellings,
occasionally even in the same page. I decided we needed
consistency, and though American is not my native spelling,
it seemed the most appropriate convention.

>>
>>> +If
>>> +.B PR_SVE_SET_VL_ONEXEC
>>> +was included in
>>> +.IR arg2 ,
>>> +the returned value describes the configuration
>>> +scheduled to take effect at the next
>>> +.BR execve (2).
>>
>> "describes the configuration" how?
>>
>>> +Otherwise, the effect is immediate and
>>> +the returned value describes the new configuration.
>>> +The returned value is encoded in the same way as the return value of
>>> +.BR PR_SVE_GET_VL .
>>
>> Aha. Maybe move this bit up slightly?
> 
> Yes, I'll reorder that.
> 
>>
>>> +.IP
>>> +If neither of the above flags is included in
>>
>> are included
> 
> Debatable.
> 
> The subject of the verb here is not "flags" (plural), but "neither of
> the above flags" (which is more nuanced, though it can be interpreted
> as singular).  Usage varies, and I don't consider this wrong.

As far as I know, the grammarians are with you on this one,
Dave, and if I was writing carefully, I'd do the same as you.
But, the plural here is also frequent (and so common that I would
hesitate to call it "wrong").

[...]


Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
