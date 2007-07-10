Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:36540 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbXGJVxo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 17:53:44 -0400
Message-ID: <4693FE48.1010606@zytor.com>
Date: Tue, 10 Jul 2007 14:46:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [x86 setup 13/33] Header file to produce 16-bit code with gcc
References: <11840359321823-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <108510B6-B9BE-49D4-BDCA-E25CA20CB29B@kernel.crashing.org> <200707101721.58937.ak@suse.de> <D6BECE27-25FA-4914-B293-4070392258D2@kernel.crashing.org> <4693EF48.1080209@zytor.com> <20070710214315.GD3492@stusta.de>
In-Reply-To: <20070710214315.GD3492@stusta.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

Adrian Bunk wrote:
>>
>> For now, I have:
> 
> Can't you use the global CFLAGS and append your specific ones?
> 

No.  A lot of the x86-64 flags don't work with -m32.

>> CFLAGS          := $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
> 
> -g ???

Leaves debugging information in setup.elf.  It is handy sometimes.

>>                    $(cflags-$(ARCH)) \
>>                    -Wall -Wstrict-prototypes \
>>                    -march=i386 -mregparm=3 \
> 
> Why -march=i386 ?

So we can at least spit out an error message.

	-hpa
