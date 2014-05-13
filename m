From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 16/25] openrisc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:41:41 +0800
Message-ID: <CAFiDJ58FJwTj5r0gEsbJgZL0HigpX0TEAxE_ARrsHV=BfWsnbw@mail.gmail.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
	<1399971958-4561-1-git-send-email-lftan@altera.com>
	<5371E62F.9090203@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5371E62F.9090203@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

On Tue, May 13, 2014 at 5:30 PM, Jonas Bonn <jonas@southpole.se> wrote:
> On 05/13/2014 11:05 AM, Ley Foon Tan wrote:
>> Override time_t and clock_t in include/uapi/asm-generic.
>>
>> diff --git a/arch/openrisc/include/uapi/asm/posix_types.h b/arch/openrisc/include/uapi/asm/posix_types.h
>> new file mode 100644
>> index 0000000..5ccf37d
>> --- /dev/null
>> +++ b/arch/openrisc/include/uapi/asm/posix_types.h
>> @@ -0,0 +1,17 @@
>> +#ifndef __ARCH_OPENRISC_POSIX_TYPES_H
>> +#define __ARCH_OPENRISC_POSIX_TYPES_H
>> +
>> +/*
>> + * This file is generally used by user-level software, so you need to
>> + * be a little careful about namespace pollution etc. Also, we cannot
>> + * assume GCC is being used.
>> + */
>
> I don't think the above comment needs to be copied to this file... given
> that the file is in the uapi/ directory, we know the file is exported to
> userspace, and the GCC comment isn't relevant given the rest of the
> files contents.
>
> But that's really just a nit!  Nice work, otherwise.
>
> Acked-by: Jonas Bonn <jonas@southpole.se>
I noticed most of the posix_types.h files in other archiectures have
this comment.
I can remove this comment if you think we don't need to add this.
Thanks.

Regards
Ley Foon
