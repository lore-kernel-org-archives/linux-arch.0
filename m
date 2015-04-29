From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 00/17] Re-introduce h8300 architecture
Date: Tue, 28 Apr 2015 21:44:30 -0700
Message-ID: <554061AE.6050105@roeck-us.net>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>	<20150428132210.GA7499@roeck-us.net> <87pp6oi2qy.wl-ysato@users.sourceforge.jp> <55405F08.7020508@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42798 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbD2Eod (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Apr 2015 00:44:33 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YnJrM-000LN1-24
	for linux-arch@vger.kernel.org; Wed, 29 Apr 2015 04:44:32 +0000
In-Reply-To: <55405F08.7020508@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 04/28/2015 09:33 PM, Guenter Roeck wrote:
> On 04/28/2015 10:25 AM, Yoshinori Sato wrote:
>> At Tue, 28 Apr 2015 06:22:10 -0700,
>> Guenter Roeck wrote:
>>>
>>> On Mon, Apr 27, 2015 at 02:35:07PM +0900, Yoshinori Sato wrote:
>>>> Hello.
>>>> I will re-introducing h8300.
>>>>
>>>
>>> Hi,
>>>
>>> can you provide a link to a working toolchain, or provide directions
>>> on how to build one ?
>>
>> h8300-unknown-linux in gcc / binutils development version.
>> Patch of a release version has not been prepared yet.
>>
>
> Hi,
>
> With a toolchain based on binutils 2.25 (patched), gcc 5.1 (unpatched), and newlib 1.20
> (unpatched), I get for both h8300h-sim_defconfig and h8s-sim_defconfig:
>
> ./arch/h8300/kernel/vmlinux.lds:247: undefined symbol `jiffies_64' referenced in expression
>
> I had to modify arch/h8300/Makefile a bit since the linker does not understand
> -mh8300helf_linux and -mh8300self_linux; I had to use -mh8300helf and -mh8300self
> instead. Maybe I am missing a binutils patch. I also had to use h8300-linux-elf
> as target to convince gcc to accept it as valid target. Both should not result
> in the undefined symbol error, though.
>

Also, a build after "make allyesconfig" shows a few missing functions.
	writel_relaxed
	readl_relaxed
	ioread32be
	iowrite32be

I should have mentioned that I used branch 'h8300' of
git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git for the build tests.

Guenter
