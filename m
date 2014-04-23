From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 04/15] arm64: __NR_compat_syscalls fix
Date: Wed, 23 Apr 2014 10:46:40 +0200
Message-ID: <CAJfpeguLJjxRu_pktaru9tL3WUo_r=cjmRzqt==M9RkH21GYaw@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-5-git-send-email-miklos@szeredi.hu>
	<20140422165814.GH10224@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:41142 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDWIqm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 04:46:42 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so603216qcx.38
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2014 01:46:40 -0700 (PDT)
In-Reply-To: <20140422165814.GH10224@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>

On Tue, Apr 22, 2014 at 6:58 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Apr 11, 2014 at 11:25:40AM +0100, Miklos Szeredi wrote:
>> From: Miklos Szeredi <mszeredi@suse.cz>
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/include/asm/unistd32.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
>> index bb8eb8a78e67..faa0e1ce59df 100644
>> --- a/arch/arm64/include/asm/unistd32.h
>> +++ b/arch/arm64/include/asm/unistd32.h
>> @@ -404,7 +404,7 @@ __SYSCALL(379, sys_finit_module)
>>  __SYSCALL(380, sys_sched_setattr)
>>  __SYSCALL(381, sys_sched_getattr)
>>
>> -#define __NR_compat_syscalls         379
>> +#define __NR_compat_syscalls         382
>
> I picked up this patch, together with a Cc: stable and longer comment.
>
> What's your plan with the other patches? Do you submit them as a series
> or would like the arch maintainers to pick them up?

Either is OK for me.  I'll collect ACKs for those which the maintainer
doesn't want to submit, and I'll submit them in one batch.

But if you have patches anyway, please feel free to pick this up as well.

Thanks,
Miklois
