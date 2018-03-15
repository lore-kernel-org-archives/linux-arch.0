Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:56735 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeCOVNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 17:13:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
        <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
        <20180308171153.GD14918@arm.com> <87o9jymbsj.fsf@xmission.com>
        <20180309131017.GB20370@arm.com>
        <20180309142557.GT32331@e103592.cambridge.arm.com>
Date: Thu, 15 Mar 2018 16:13:02 -0500
In-Reply-To: <20180309142557.GT32331@e103592.cambridge.arm.com> (Dave Martin's
        message of "Fri, 9 Mar 2018 14:25:57 +0000")
Message-ID: <87vadxyrdt.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/3] arm64: fpsimd: Fix bad si_code for undiagnosed SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180315211302._Phik0Qhk3-hh3sZfYYrvDCIssMfGzWssADWN-aPX8k@z>

Dave Martin <Dave.Martin@arm.com> writes:

> On Fri, Mar 09, 2018 at 01:10:18PM +0000, Will Deacon wrote:
>> Hi Eric,
>> 
>> On Thu, Mar 08, 2018 at 04:40:12PM -0600, Eric W. Biederman wrote:
>> > Will Deacon <will.deacon@arm.com> writes:
>> > > Happy to take this patch once the dependency on FPE_FLTUNK in core code is
>> > > resolved.
>> > 
>> > Would it help for me to take the FPE_FLTUNK patch into my siginfo-next
>> > branch?   So that there is a common branch with the code so we don't
>> > need to worry about conflicts.  If so I will look at that on Monday.
>> 
>> Yes please, that would be helpful actually. I can then pull that into
>> arm64 if you give me a stable branch or tag. Alternatively, I can define
>> FPE_FLTUNK locally and remove it at -rc1.
>
> OK Eric, let me know if you need me to rebase anything for the first 2
> patches.

The first patch is now in my siginfo-next tree and avialable at:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-next
HEAD: 266da65e9156d93e1126e185259a4aae68188d0e signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions

I will not rebase this branch, so please fee free to merge it into other
trees.

Eric
