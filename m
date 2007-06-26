Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:50508 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759742AbXFZT3w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jun 2007 15:29:52 -0400
Message-ID: <468168FD.1080200@goop.org>
Date: Tue, 26 Jun 2007 15:29:01 -0400
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cross-architecture ELF clean up
References: <20070620230854.246399397@goop.org> <20070620230902.387008536@goop.org> <Pine.LNX.4.64.0706251531110.4386@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0706251531110.4386@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-arch.vger.kernel.org>

Roman Zippel wrote:
>> This patch cleans up the ELF headers and their users.  It does several
>> related things:
>>
>> 1. split linux/elf.h into pieces
>>
>> This splits linux/elf.h into several pieces:
>> 	linux/elf.h		- still the common elf header,
>> 				  functionally unchanged
>> 	linux/elf-const.h	- ELF constants, includable by asm code
>>     
>
> We have the __ASSEMBLY__ define for this, so just for asm code we don't 
> need a separate header.
>   

Hm.  The number of __ASSEMBLY__s end up being pretty large, and it just 
seemed cleaner to put them in separate headers.

>> 	linux/elf-decl.h	- ELF type declarations, without definitions
>> 	linux/elf-defn.h	- ELF type definitions
>>     
>
> What's the point in splitting these two?
>   

Because there are other headers which just need some type 
forward-declarations, and don't need the whole set of ELF types 
defined.  In particular, linux/module.h - which is included all over the 
place in the kernel - needs a couple of ELF types declared, and 
including it all over the place is just a waste.  Also, there were some 
nasty cyclic header dependency problems around linux/elf.h, 
linux/module.h, linux/bug.h and asm/bug.h which ended up leading to some 
awkward hacks; I need to remind myself what the problems were and see if 
this elf cleanup helps (pretty sure it should).

> After this patch <linux/elf.h> seems to be pretty much empty, I'd rather 
> suggest to move the function declarations to elfcore.h and leave the basic 
> elf definitions in elf.h. Many small header files have the disadvantage 
> that it takes longer to find the needed information.
>   
linux/elf.h ends up pulling in a really surprising amount of stuff, 
mostly because it ends up including asm/elf.h.  asm/elf.h, in turn, 
depending on the architecture, pulls in a wide variety of other 
headers.  When I cleaned this up, I found quite a few buggy .c files 
which ended up relying on implicit includes via this chain.

Given that there's been a general push to try and cut down on the number 
of header dependency entanglements, I thought I could contribute while 
solving my own immediate problems.

linux/elfcore.h is specifically related to ELF core files, so the two 
corefile notes-related headers could be moved there.

    J
