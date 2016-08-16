Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43632 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbcHPF5e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Aug 2016 01:57:34 -0400
Subject: Re: [RFC][PATCHSET v2] allowing exports in *.S
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <20160203211953.GT17997@ZenIV.linux.org.uk> <57A0A7B8.7080107@suse.cz>
 <57B2A920.5000802@suse.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <57B2AB42.2090600@suse.com>
Date: Tue, 16 Aug 2016 07:57:22 +0200
MIME-Version: 1.0
In-Reply-To: <57B2A920.5000802@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160816055722.LTDcj0RyrI9kXYIFqL5vy0hKPhPm1RH-fj94OjI7PIU@z>

Dne 16.8.2016 v 07:48 Michal Marek napsal(a):
> Dne 2.8.2016 v 16:01 Michal Marek napsal(a):
>> On 2016-02-03 22:19, Al Viro wrote:
>>> Shortlog:
>>> Al Viro (13):
>>>       [kbuild] handle exports in lib-y objects reliably
>>>       EXPORT_SYMBOL() for asm
>>>       x86: move exports to actual definitions
>>>       alpha: move exports to actual definitions
>>>       m68k: move exports to definitions
>>>       s390: move exports to definitions
>>>       arm: move exports to definitions
>>>       ppc: move exports to definitions
>>>       ppc: get rid of unreachable abs() implementation
>>>       sparc: move exports to definitions
>>>       [sparc] unify 32bit and 64bit string.h
>>>       sparc32: debride memcpy.S a bit
>>>       ia64: move exports to definitions
>>
>> After several pings by Al (sorry about that!), I got around to review a
>> rebased version of this patchset at
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git asm-exports
>>
>> The kbuild commits are good, but since we are close to the end of the
>> merge window, I will apply them to my kbuild branch after 4.8-rc1.
> 
> The rebased patchset is now in kbuild.git#kbuild. Before pushing, I
> noticed one issue: For some reason,
> drivers/firmware/efi/libstub/lib-ksyms.o is regenerated each time,
> leading to relink of vmlinux. I'm looking into this.

OK, it's the

$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
        $(call if_changed_rule,cc_o_c)

rule in drivers/firmware/efi/libstub/Makefile file that conflicts with
the lib-ksyms.o rule. I need to find a better solution to this hack.

Michal
