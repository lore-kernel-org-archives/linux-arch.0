From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: What's in asm-generic.git
Date: Thu, 10 Dec 2009 16:17:44 -0500
Message-ID: <8bd0f97a0912101317v8143e67w9e2f1224111ac0d7@mail.gmail.com>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
	<200912071614.46166.arnd@arndb.de> <200912102210.12124.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761727AbZLJVSF@vger.kernel.org>
In-Reply-To: <200912102210.12124.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

2009/12/10 Arnd Bergmann:
> On Monday 07 December 2009, Arnd Bergmann wrote:
>> On Monday 07 December 2009, liqin.chen@sunplusct.com wrote:
>> > Arnd Bergmann <arnd@arndb.de> =E5=86=99=E4=BA=8E 2009-12-04 03:14:=
08:
>> >
>> > Maybe you can add a __NR_set_thread_area define in asm-generic/uns=
itd.h
>> > for tls used.
>>
>> Yes, good point. I'll update the syscall list with this, and also ch=
eck if more
>> syscalls have been addded.
>
> I have found now that sys_accept4 was missing. sys_set_thread_area ho=
wever
> is only defined on x86 and mips. Since you don't currently implement =
this
> on score, maybe it would be more appropriate to handle it like the ot=
her
> architectures do, rather than adding it to asm-generic/unistd.h?

isnt the point of asm-generic/unistd.h to collect all common syscalls
?  if there's syscalls that ideally should be handled by everyone but
currently doesnt, then it's easy to define it in the header but have
the actual entry.S leave it as a hole ...

or maybe i'm missing what's going on
-mike
