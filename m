Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:42236 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbbCJGRd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 02:17:33 -0400
Message-ID: <54FE8C79.2000104@codesourcery.com>
Date: Tue, 10 Mar 2015 14:17:29 +0800
From: Chung-Lin Tang <cltang@codesourcery.com>
MIME-Version: 1.0
Subject: Re: nios2: is the ptrace ABI correct?
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com>	<10088870.tldQegtTla@wuerfel>	<54EDB2FC.4050901@vanguardiasur.com.ar>	<10841724.NbdcAaCe1a@wuerfel>	<54F03184.7080600@codesourcery.com>	<54F052B1.4070300@vanguardiasur.com.ar>	<54FDD041.3080500@codesourcery.com>	<54FDD219.1060707@gmail.com>	<54FDD2D8.8090509@vanguardiasur.com.ar> <CAFiDJ5_gstXn-y8JSzi=gy+nRrrFqCaQA_R4CVg0+vhLz1EZPw@mail.gmail.com>
In-Reply-To: <CAFiDJ5_gstXn-y8JSzi=gy+nRrrFqCaQA_R4CVg0+vhLz1EZPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Chung-Lin Tang <chunglin.tang@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Tobias Klauser <tklauser@distanz.ch>, Walter Goossens <waltergoossens@home.nl>, Linux-Arch <linux-arch@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150310061729.y2TAKpFECnol1aYmXZY1e1Cb9ogLb4DNKjSGO-xlidY@z>

On 2015/3/10 10:54 AM, Ley Foon Tan wrote:
> On Tue, Mar 10, 2015 at 1:05 AM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>>
>>
>> On 03/09/2015 02:02 PM, Chung-Lin Tang wrote:
>>> On 2015/3/10 12:54 AM, Chung-Lin Tang wrote:
>>>> It appears that some of the ways nios2 has organized the
>>>> ucontext/pt_regs/etc. are remnants of the pre-generic code, some
>>>> basically because the port was based off m68k.
>>>>
>>>> I've re-organized the headers a bit: nios2/include/asm/ucontext.h is
>>>> deleted, and re-definition of struct sigcontext now allows use of
>>>> uapi/asm-generic/ucontext.h directly.  Note that the reorg, despite
>>>> effectively renaming some fields, is still binary compatible. I'll
>>>> probably update the corresponding glibc definitions later.
>>>>
>>>> struct pt_regs is now not exported, and all exported register sets are
>>>> now supposed to follow the 49 register set defined as in GDB now.
>>>>
>>>> Tobias, Ley Foon, how do you think this looks?
>>>
>>> Sorry, accidentally attached unrelated GCC patch instead, this one's the
>>> correct one.
>>>
>>
>> Looks good. I'm wondering if...
>>
>> +/* User structures for general purpose registers.  */
>> +struct user_pt_regs {
>> +       __u32           regs[49];
>>  };
>>
>> Can we expose the registers explicitly here? Like this:
>>
>> struct user_pt_regs {
>>         __u32 r0;
>>         __u32 r1;
>>         ...
>>         __u32 sp;
>>         __u32 gp;
>>         __u32 estatus;
>> };
>>
>> It looks self-documenting and thus easier to use.
> 
> Hi Chung-Lin,
> 
> Your patch look good to me.
> Do you have any problem to change the struct user_pt_regs based on
> Ezequiel's suggestion?

Well, exposing the register names like that sort of defeats the purpose of
the PTR_* defines.

Judging from the overall trend of style in arch/*/include/uapi/asm/ptrace.h
across ports, I would prefer to stay with the array field.

Thanks,
Chung-Lin

