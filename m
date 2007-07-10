Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54483 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760903AbXGJWGa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jul 2007 18:06:30 -0400
In-Reply-To: <4693FCE7.2060308@zytor.com>
References: <11840359321823-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <108510B6-B9BE-49D4-BDCA-E25CA20CB29B@kernel.crashing.org> <200707101721.58937.ak@suse.de> <D6BECE27-25FA-4914-B293-4070392258D2@kernel.crashing.org> <4693EF48.1080209@zytor.com> <763AC431-73A6-4A5F-9453-A66A86D7DEEB@kernel.crashing.org> <4693FCE7.2060308@zytor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3598C6DD-D62C-4DB5-99D7-5B4420A0EAB2@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [x86 setup 13/33] Header file to produce 16-bit code with gcc
Date: Wed, 11 Jul 2007 00:06:11 +0200
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

>> Looks good, except you don't want -fno-unit-at-a-time if
>> -fno-toplevel-reorder works.  And of course it would be
>> good to get rid of -fno-strict-aliasing, but let's not
>> go there today ;-P
>
> OK, how does this look:
>
> CFLAGS          := $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
>                    $(cflags-$(ARCH)) \
>                    -Wall -Wstrict-prototypes \
>                    -march=i386 -mregparm=3 \
>                    -include $(srctree)/$(src)/code16gcc.h \
>                    -fno-strict-aliasing -fomit-frame-pointer \
>                    $(call cc-option, -ffreestanding) \
>                    $(call cc-option, -fno-toplevel-reorder,\
>                         $(call cc-option, -fno-unit-at-a-time)) \
>                    $(call cc-option, -fno-stack-protector) \
>                    $(call cc-option, -mpreferred-stack-boundary=2)

That looks fine.

> I think dropping -fno-strict-aliasing for this code is probably bad...
> it's pretty low-level stuff which does a lot of bitlevel manipulation.

"Which breaks C aliasing rules all over the place".  Well,
probably not all that often, actually.  But, as I said --
let's not go there now, keep the flag in there, removing
it will take a lot of work.


Segher

