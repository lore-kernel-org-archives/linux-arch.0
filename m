From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] allow placing exception table in .rodata (and do
	 so on x86)
Date: Thu, 28 Apr 2011 13:07:07 +0100
Message-ID: <4DB9748B020000780003EA01@vpn.id2.novell.com>
References: <4DB85404020000780003E6D7@vpn.id2.novell.com>
 <20110428104306.GC2431@osiris.boeblingen.de.ibm.com>
 <4DB96E6A020000780003E9EB@vpn.id2.novell.com>
 <BANLkTikJN92ogUfxAc+SgzvX1Q8r48ughw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <BANLkTikJN92ogUfxAc+SgzvX1Q8r48ughw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

>>> On 28.04.11 at 13:47, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Apr 28, 2011 at 13:40, Jan Beulich <JBeulich@novell.com> wrote:
>>>>> On 28.04.11 at 12:43, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>>> On Wed, Apr 27, 2011 at 04:36:04PM +0100, Jan Beulich wrote:
>>>> This is since the table is really a set of pointers, i.e. misplaced in
>>>> .text.
>>>>
>>>> Quite likely other architectures would want to follow.
>>>>
>>>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>>>>
>>>
>>> [...]
>>>
>>>> --- 2.6.39-rc5/include/asm-generic/vmlinux.lds.h
>>>> +++ 2.6.39-rc5-extable-in-rodata/include/asm-generic/vmlinux.lds.h
>>>> @@ -226,6 +226,7 @@
>>>>              *(.rodata1)                                             \
>>>>      }                                                               \
>>>>                                                                      \
>>>> +    EXCEPTION_TABLE_RO                                              \
>>>
>>> That's odd. The kernel actually writes to it (sort_main_extable()), so
>>> it shouldn't be in the ro data section, but the data section.
>>
>> This area does get written, but only at boot time, before read-only
>> data gets set to r/o (on x86 at least). With this in mind, it's better
>> to place it in .rodata, as that way run-time protection will be in place
>> (and I think you agree that it was misplaced in .text in any case).
> 
> Which means it may be in ROM (which is really read-only) on some embedded
> devices, so it cannot be sorted?

Perhaps - but since sorting is a requirement, people building such
systems must have found a way... Anyway, I don't see where both
your and Heiko's comment are heading, since the situation is even
worse without the patch afaics (since .text gets marked read-only
as much as .rodata does, and could equally be placed in ROM).

Jan
