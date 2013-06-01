From: schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [PATCH] arch: m68k: include: asm: the 3rd parameter of 'insl'
 and 'outsl' need '<< 2'
Date: Sat, 01 Jun 2013 12:38:25 +1200
Message-ID: <51A94281.7050708@biophys.uni-duesseldorf.de>
References: <51A71E49.1000707@asianux.com> <CAMuHMdUz8o4d=RiAMW8-pCrnZyfoH9EETVqjcb7E1GqCgYmQ7g@mail.gmail.com> <51A93FA0.1050203@biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <51A93FA0.1050203@biophys.uni-duesseldorf.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chen Gang <gang.chen@asianux.com>, Greg Ungerer <gerg@uclinux.org>, schmitz@debian.org, Sam Ravnborg <sam@ravnborg.org>, Greg KH <gregkh@linuxfoundation.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

All,
> Geert ,
>>>
>>> The related git number:
>>>   for parport.h: "4914802 m68k,m68knommu: merge header files" in 2009
>>>   for io_mm.h: "84b16b7 m68k/atari: ROM port ISA adapter support" in 
>>> Apr 6 2013
>>>
>>> The related warning (make EXTRA_CFLAG=-W ARCH=m68k allmodconfig):
>>>   arch/m68k/include/asm/parport.h:14:0: warning: "insl" redefined 
>>> [enabled by default]
>>>   arch/m68k/include/asm/io_mm.h:403:0: note: this is the location of 
>>> the previous definition
>>>   arch/m68k/include/asm/parport.h:15:0: warning: "outsl" redefined 
>>> [enabled by default]
>>>   arch/m68k/include/asm/io_mm.h:406:0: note: this is the location of 
>>> the previous definition
>>>     
> Is that the same problem Thorsten reported recently? parport.h should 
> either use what the arch io.h include defined, or (in the case of Q40 
> on m68k) undef and redefine as needed.
It appears this is the same issue, see message ID 
loom.20130511T171757-995@post.gmane.org to linux-m68k (May 12th, by 
Thorsten Glaser).

This _only_ applies to use of insl/outsl macros in parport_pc.h, which 
is only used by Q40 on m68k. I see no reason to change anything in io.h 
to cope with this warning.

Cheers,

    Michael

>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  arch/m68k/include/asm/io_mm.h   |    5 +++--
>>>  arch/m68k/include/asm/parport.h |    9 +++++++--
>>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/m68k/include/asm/io_mm.h 
>>> b/arch/m68k/include/asm/io_mm.h
>>> index ffdf54f4..66be3b2 100644
>>> --- a/arch/m68k/include/asm/io_mm.h
>>> +++ b/arch/m68k/include/asm/io_mm.h
>>> @@ -400,10 +400,11 @@ static inline void isa_delay(void)
>>>
>>>  #define insb(port, buf, nr)    ((port) < 1024 ? 
>>> isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
>>>  #define insw(port, buf, nr)    ((port) < 1024 ? 
>>> isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
>>> -#define insl                   isa_insl
>>> +#define insl(port, buf, len)   isa_insb((port), (buf), (len) << 2)
>>>     
>>
>> Oops, changes from 32-bit accesses to byte accesses?
>>   
>
> That's in the Atari specific branch - please explain why you think 
> this needs to be done. Has this patch been tested by running on 
> ARAnyM, at least?
>
> Unless this has  been properly  tested on Atari (hardware), please 
> leave as-is.
>
>>  
>>>  #define outsb(port, buf, nr)   ((port) < 1024 ? 
>>> isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
>>>  #define outsw(port, buf, nr)   ((port) < 1024 ? 
>>> isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
>>> -#define outsl                  isa_outsl
>>> +#define outsl(port, buf, len)  isa_outsb((port), (buf), (len) << 2)
>>>
>>>  #define readb(addr)            in_8(addr)
>>>  #define writeb(val, addr)      out_8((addr), (val))
>>> diff --git a/arch/m68k/include/asm/parport.h 
>>> b/arch/m68k/include/asm/parport.h
>>> index 5ea75e6..e8e4a2a 100644
>>> --- a/arch/m68k/include/asm/parport.h
>>> +++ b/arch/m68k/include/asm/parport.h
>>> @@ -11,8 +11,13 @@
>>>  #ifndef _ASM_M68K_PARPORT_H
>>>  #define _ASM_M68K_PARPORT_H 1
>>>
>>> -#define insl(port,buf,len)   isa_insb(port,buf,(len)<<2)
>>> -#define outsl(port,buf,len)  isa_outsb(port,buf,(len)<<2)
>>> +#ifndef insl
>>> +#define insl(port, buf, len)   isa_insb((port), (buf), (len) << 2)
>>> +#endif
>>> +
>>> +#ifndef outsl
>>> +#define outsl(port, buf, len)  isa_outsb((port), (buf), (len) << 2)
>>> +#endif
>>>     
> I think that should read
> #undef insl
> #define insl(port,buf,len) isa_insb(port,buf,(len)<<2)
>
> instead. I distinctly remember this brought up a few weeks ago.
>> Now the (re)definitions are identical to the originals, so they can just
>> be removed. But the ones in <asm/io.h> are not correct anymore, IMHO.
>>   
> Seconded.
>
> Cheers,
>
>    Michael
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
