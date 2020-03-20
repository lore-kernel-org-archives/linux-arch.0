Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:49790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgCTOld (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:41:33 -0400
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
References: <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
 <20200317174806.GE632169@arrakis.emea.arm.com>
 <93cfe94a-c2a3-1025-bc9c-e7c3fd891100@arm.com>
 <20200318183603.GF94111@arrakis.emea.arm.com>
 <1bc25a53-7a59-0f60-ecf2-a3cace46b823@arm.com> <20200319181004.GA29214@mbp>
 <b937d1eb-c7fd-e903-fa36-b261662bf40b@arm.com> <20200320142208.GC29214@mbp>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <46add8e3-dd04-9194-4196-4d8e5cd4c70f@arm.com>
Date: Fri, 20 Mar 2020 14:41:57 +0000
MIME-Version: 1.0
In-Reply-To: <20200320142208.GC29214@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, linux-mips@vger.kernel.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org, Andrei Vagin <avagin@openvz.org>, Stephen Boyd <sboyd@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>
Message-ID: <20200320144157.6-MaFB30NGmU-bLd8NyT9IFxVsaxS3YDSAAp2ID-lOw@z>

Hi Catalin,

On 3/20/20 2:22 PM, Catalin Marinas wrote:
> On Fri, Mar 20, 2020 at 01:05:14PM +0000, Vincenzo Frascino wrote:
>> On 3/19/20 6:10 PM, Catalin Marinas wrote:
>>> On Thu, Mar 19, 2020 at 12:38:42PM +0000, Vincenzo Frascino wrote:
>>>> On 3/18/20 6:36 PM, Catalin Marinas wrote:
>>>>> On Wed, Mar 18, 2020 at 04:14:26PM +0000, Vincenzo Frascino wrote:
>>>>>> On 3/17/20 5:48 PM, Catalin Marinas wrote:
[...]

>>
>> Thank you for the long chat this morning. As we agreed I am going to repost the
>> patches removing the checks discussed in this thread
> 
> Great, thanks.
> 
>> and we will address the syscall ABI difference subsequently with a
>> different series.
> 
> Now I'm even less convinced we need any additional patches. The arm64
> compat syscall would still return -EFAULT for res >= TASK_SIZE_32
> because copy_to_user() will fail. So it would be entirely consistent
> with the arm32 syscall. In the vdso-only case, both arm32 and arm64
> compat would generate a signal.
> 
> As Will said, arguably, the syscall semantics may not be applicable to
> the vdso implementation. But if you do want to get down this route (tp =
> UINTPTR_MAX - sizeof(*tp) returning -EFAULT), please do it for all
> architectures, not just arm64 compat. However, I'm not sure anyone
> relies on this functionality, other than the vdsotest, so no real
> application broken.
> 

It is ok, we will discuss the topic once we cross that bridge. I am already
happy that I managed to explain finally my reasons ;)

Anyway, I think that if there is an application that relies on this behavior (or
similar) and uses compat we will discover it as soon as these patches will be
out in the wild. For this reason I am putting a link to this discussion in the
commit message of the relevant patch so that we can take it from there.

-- 
Regards,
Vincenzo
