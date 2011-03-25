From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Link breakage on all architectures which implement their own show_mem
Date: Fri, 25 Mar 2011 14:38:07 -0400
Message-ID: <AANLkTi==Ddg-Dx6w==MG4f4rbvLXCxY1c9NieitJctJC@mail.gmail.com>
References: <1300898506.15899.24.camel@mulgrave.site>
	<alpine.DEB.2.00.1103241520120.26730@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56600 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887Ab1CYSiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Mar 2011 14:38:09 -0400
Received: by wya21 with SMTP id 21so1348030wya.19
        for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2011 11:38:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103241520120.26730@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org

On Thu, Mar 24, 2011 at 6:21 PM, David Rientjes <rientjes@google.com> w=
rote:
> On Wed, 23 Mar 2011, James Bottomley wrote:
>
>> This is the problem a lot of architectures will see:
>>
>> Specifically this:
>> =A0 LD =A0 =A0 =A0vmlinux.o
>> lib/lib.a(show_mem.o): In function `show_mem':
>> (.text.show_mem+0x0): multiple definition of `show_mem'
>> arch/parisc/mm/built-in.o:(.text.show_mem+0x0): first defined here
>> make: *** [vmlinux.o] Error 1
>>
>> Caused by this patch:
>>
>> commit ddd588b5dd55f14320379961e47683db4e4c1d90
>> Author: David Rientjes <rientjes@google.com>
>> Date: =A0 Tue Mar 22 16:30:46 2011 -0700
>>
>> =A0 =A0 oom: suppress nodes that are not allowed from meminfo on oom=
 kill
>>
>> Is the cause. =A0What it does is introduce a new __show_mem() which =
is
>> required by files in mm/, so the object containing it: show_mem.o ge=
ts
>> pulled in all the time in the link and that gives every architecture
>> that implements their own show_mem() a link failure because of the
>> double definition. =A0Library linking works at the file level, not a=
t the
>> function level. =A0To work, you have to put these functions in separ=
ate
>> files.
>>
>
> Thanks for the report, James.
>
> This was also reported by Stephen on LKML when he merged the latest L=
inus
> tree into linux-next. =A0Andrew suggested that we remove __show_mem()
> entirely and simply add its argument to show_mem() in all the
> architectures. =A0I have a patch at:
>
> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-kernel&m=3D130100511521954
>
> I don't have a parisc cross compiler, so if you could try it out and =
add
> your Tested-by that would be great

You can find basic cross compilers for a variety of architectures
already built here:

http://www.kernel.org/pub/tools/crosstool/

josh
