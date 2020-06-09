Return-Path: <SRS0=6fqV=7W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFILDi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:03:38 -0400
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <20200609100202.GB25362@willie-the-truck>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7571ba40-7b4e-ca6d-efb1-691b1c4a6d04@gmail.com>
Date: Tue, 9 Jun 2020 13:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200609100202.GB25362@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20200609110335.1lSm4f8Nctz9ElkMzCpp3Fu90VBbAm2IvLJ5qPKj3cI@z>

Hi Will,

Thanks for reviewing.

On 6/9/20 12:02 PM, Will Deacon wrote:
> On Wed, May 27, 2020 at 10:17:37PM +0100, Dave Martin wrote:
>> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
>> 5.0 for arm64.
> 
> [...]
> 
>> +If the arguments are invalid,
>> +and in particular if
>> +.I arg2
>> +contains set bits that are unrecognized
>> +or that correspond to a key not available on this platform,
>> +the call fails with error
>> +.BR EINVAL .
>> +.IP
>> +.B Warning:
>> +Because the compiler or run-time environment
>> +may be using some or all of the keys,
>> +a successful
>> +.IP
>> +For more information, see the kernel source file
>> +.I Documentation/arm64/pointer\-authentication.rst
>> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
>> +(or
>> +.I Documentation/arm64/pointer\-authentication.txt
>> +before Linux 5.3).
>> +.B PR_PAC_RESET_KEYS
>> +may crash the calling process.
> 
> I might be misreading this, but this looks like the kernel reference appears
> mid-sentence. 

It's hidden as a comment (.\").

> Regardless, I think we should drop the kernel doc reference,
> as I mentioned on the SVE patches.

I actually request that people add these kinds of comments in the source.
It helps me verify details in patches, and is also handy when checking
details in the future.

> With that:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
