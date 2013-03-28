From: Chris Zankel <chris@zankel.net>
Subject: Re: [patch 00/34] idle: Consolidate idle implementations
Date: Thu, 28 Mar 2013 15:16:09 -0700
Message-ID: <5154C129.9040807@zankel.net>
References: <20130321214930.752934102@linutronix.de> <alpine.LFD.2.02.1303271940150.22263@ionos> <5153EC43.7070808@zankel.net> <alpine.LFD.2.02.1303281023020.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39635 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3C1WQN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 18:16:13 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so5597pdj.41
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2013 15:16:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1303281023020.22263@ionos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

Hi Thomas,

On 3/28/13 2:24 AM, Thomas Gleixner wrote:
> On Thu, 28 Mar 2013, Chris Zankel wrote:
>
>> For Xtensa:
>> Acked-by: Chris Zankel <chris@zankel.net>
>>
>> Thanks for going the extra mile and test-compiling it.
> Though, the build fails later with:
>
> arch/xtensa/kernel/built-in.o:(.init.literal+0x90): undefined reference to `platform_pcibios_init'
> arch/xtensa/kernel/built-in.o: In function `setup_arch':
> (.init.text+0x1de): undefined reference to `platform_pcibios_init'
> drivers/built-in.o: In function `pci_assign_unassigned_resources':
[...]

Thanks for the info. With KALLSYMS enabled, the .rodata section between 
the .text and the .init.text section is extended to a point where it 
exceeds the call range between those sections. I'm working on a fix 
(basically, move the .init.text section close to the .init section).

Thanks,
-Chris
