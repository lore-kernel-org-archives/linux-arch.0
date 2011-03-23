From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Wed, 23 Mar 2011 18:06:00 +0530
Message-ID: <AANLkTikU=eTioeESyLJyOe=DX0ewJ_1HFDrcOXJHErux@mail.gmail.com>
References: <AANLkTinSMPPHzmp5e1JrPByXC0XCY-591S=jGATXHR=U@mail.gmail.com>
	<4D87363A.7090209@snapgear.com>
	<AANLkTik1jSNpuREDuX3-LhNafD43m5T=14ZDwNUC5a8X@mail.gmail.com>
	<4D89E270.1080001@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46785 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763Ab1CWMgB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2011 08:36:01 -0400
Received: by wwa36 with SMTP id 36so10062859wwa.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2011 05:36:00 -0700 (PDT)
In-Reply-To: <4D89E270.1080001@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-arch@vger.kernel.org

Hi Greg,

Thanks for your information.

On Wed, Mar 23, 2011 at 5:37 PM, Greg Ungerer <gerg@snapgear.com> wrote=
:
> Hi Madhavi,
>
> On 22/03/11 22:43, Madhavi Manchala wrote:
>>
>> Thank you very much for your valuable information and suggestions.
>>
>> On Mon, Mar 21, 2011 at 4:57 PM, Greg Ungerer<gerg@snapgear.com> =A0=
wrote:
>>>
>>> On 19/03/11 01:54, Madhavi Manchala wrote:
>>>>
>>>> I have one basic question about the architecture files in Linux
>>>> kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
>>>> which is a no-mmu based CPU. I heard that "there was not a lot of =
ARM
>>>> no-mmu support at the moment" from Ben Dooks.
>>>
>>> The core is there, but there is very little specific machine suppor=
t.
>>> The one I use for testing is non-MMU ARM is the Atmel/AT91X40 (that=
 is
>>> CONFIG_ARCH_AT91X40). I don't run it on real hardware, but on the
>>> SkyEye emulator.
>>
>> I saw the mach-at91/at91x40.c and mach-at91/at91x40_time.c file
>> sources. There is a few lines of code is available in these two file=
s.
>> I guess, some of the common files are there for all Atmel boards and
>> that is also included as a part of at91x40 board. Am I correct?
>
> Yes, exactly. Much of the code is shared by all type of at91 parts,
> irrespective of whether they have the MMU or not. (Most of the
> internal peripherals at either the same or very similar - so
> things like interrupts, etc).
>
>
>> I found only at91_aic_init() function only called from at91x40.c fil=
e.
>> What about other initialization like serial etc.? =A0Is this include=
d
>> from common files for Atmel boards?
>
> Serial is a problem for this target, it is a little different
> on the old at91x40 series to most of the newer at91 parts. Currently
> it requires a different driver than the standard at91 serial driver.
> (And that driver is not in mainline, and is not a platform type
> driver either).
>
>
>>>> So, I started developing the architecture files for my Samsung
>>>> S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
>>>> (ARM920 core) architecture files. Is this my porting (developing t=
he
>>>> architecture files) correct?
>>>
>>> Would make sense to start on something similar, yes.
>>
>> I downloaded the latest uClinux sources from
>> http://sourceforge.net/projects/uclinux/files/uClinux%20Stable/ and
>> the name of the file is uClinux-dist-20101026.tar.bz2. In this
>> distribution, I found mach-s3c24a0, mach-s3c3410, s3c44b0x and
>> mach-s5c7375 sources in linux-2.6.x/arch/arm/ directory. (Arnd asked
>> me to see these sources as a reference, only). So, I am looking at
>> these sources and especially s3c3410 sources as remaining are
>> different like s3c24a0 is a MMU based etc.
>>
>>>
>>>> How can I port the Linux on to my board which has a Samsung S3C251=
0A
>>>> MCU (ARM940T core) which is a NO-MMU based CPU?
>>>>
>>>> Thanks for your suggestions / hints / comments.
>>>
>>> You can look at what I did with the AT91X40 for an example.
>>> Or look at the patches that Ithamar Adema sent to the ARM linux
>>> mailing list in the last few days for supporting the NXP LPC2K
>>> family as another example (they are also non-MMU parts).
>>
>> As I said above, there are only two files which are related to at91x=
40
>> board. However, I found some sources for the Ithamar Adema patches a=
t
>> the following link.
>> http://www.spinics.net/lists/arm-kernel/msg118932.html
>>
>> These sources (patches) are similar to samsung sources which are
>> available in uClinux-dist. So, I will look into the Ithamar Adema
>> patches and uClinux-dist samsung machine directory sources. Please
>> suggest me.
>
> Looking at all of these will be useful. The AT91 changes where quite
> simple due to the high degree of similarity.

Do you mean similarity between AT91 and S3C2510A processors? Am I
understand your statement correct?

Thanks and Regards,
Madhavi M.

>
>> My final question, All these samsung machines (s3c24a0, s3c3410,
>> s3c44b0x and s5c7375) are ARM7TDMI core based MCUs. My MCU (Samsung
>> s3c2510A) is a ARM9TDMI core based. So, is this porting will help?
>>
>> I am extreamly sorry, If I asked silly questions here.
>>
>> Once again, thanks for your suggestions and valuable inforamtion.
>
> No problem, glad to help.
>
> Regards
> Greg
>
>
> ---------------------------------------------------------------------=
---
> Greg Ungerer =A0-- =A0Principal Engineer =A0 =A0 =A0 =A0EMAIL: =A0 =A0=
 gerg@snapgear.com
> SnapGear Group, McAfee =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PHO=
NE: =A0 =A0 =A0 +61 7 3435 2888
> 8 Gardner Close =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 FAX: =A0 =A0 =A0 =A0 +61 7 3217 5323
> Milton, QLD, 4064, Australia =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WEB: http=
://www.SnapGear.com
>
