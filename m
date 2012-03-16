From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 13/35] Disintegrate asm/system.h for M68K [ver #2]
Date: Fri, 16 Mar 2012 11:05:10 +1000
Message-ID: <4F6291C6.4040903@snapgear.com>
References: <4F608A15.9030609@snapgear.com> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233816.13888.142.stgit@warthog.procyon.org.uk> <7100.1331842713@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <7100.1331842713@redhat.com>
Sender: linux-m68k-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Hi David,

On 16/03/12 06:18, David Howells wrote:
> Greg Ungerer<gerg@snapgear.com>  wrote:
>> This breaks compilation for m68k targets with:
>>
>>    CC      net/ipv4/ip_input.o
>> In file included from
>> /home/gerg/new-wave.320/linux-3.x/arch/m68k/include/asm/system.h:3:0=
,
>>                   from net/ipv4/ip_input.c:116:
>> /home/gerg/new-wave.320/linux-3.x/arch/m68k/include/asm/cmpxchg.h: I=
n function
>> =C3=A6__xchg=C3=86:
>> /home/gerg/new-wave.320/linux-3.x/arch/m68k/include/asm/cmpxchg.h:33=
:3: error:
>> implicit declaration of function =C3=A6BUG=C3=86
>>
>> The old system.h included linux/kernel.h which includes asm/bug.h.
>> Just including asm/bug.h here in cmpxchg.h is not enough to fix it.
>> If you include linux/kernel.h though it compiles cleanly.
>
> Which targets, btw?

Looks to be all the non-MMU ones.

So that is the following defconfigs: m5208evb, m5249evb m5272c3,
m5275evb, m5307c3 and m5407c3. For example this configure line:

     make ARCH=3Dm68k CROSS_COMPILE=3Dm68k-uclinux- m5208evb_defconfig

Regards
Greg


-----------------------------------------------------------------------=
-
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.co=
m
SnapGear Group, McAfee                      PHONE:       +61 7 3435 288=
8
8 Gardner Close                             FAX:         +61 7 3217 532=
3
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.co=
m
