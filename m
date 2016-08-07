From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC][PATCH 0/5] kbuild changes, thin archives, --gc-sections
Date: Sun, 07 Aug 2016 22:23:02 +0200
Message-ID: <8649964.jra1Y5q7Kz@wuerfel>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbcHGUXP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 16:23:15 -0400
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Friday, August 5, 2016 10:11:58 PM CEST Nicholas Piggin wrote:
> Hello,
> 
> I have 3 different things in this patchset. All arch specific, but all
> involve kbuild changes, so I'd like to discuss them with kbuild
> maintainers. The goal has been to improve long standing linking
> difficulties with the powerpc kernel.
> 
> * First, building kernel using thin archives rather than incremental
>   linking. This seems quite clean and is per-arch, so I hope it should
>   not be too controversial.
> 
> * Second, building kernel using -ffunction-sections -fdata-sections,
>   --gc-sections. Yes, I'm spinning the wheel again. It was motivated
>   by tiny codesize regression in the first patch, but the results seem
>   too good to ignore.
> 
> * Third, allowing architecture to run a tool over module after it has
>   been linked. Powerpc wants to use it in order to relocate "alternate
>   code" instructions that get don't get linked at their runtime
>   address. No idea if this is the right approach wrt kbuild, but it
>   seems to work.
> 
> I have included the powerpc code for the first two as a reference. The
> third is much bigger and mostly uninteresting for this cc list, but it
> can be found here:
> 
>  https://patchwork.ozlabs.org/patch/651006/
> 
> Comments appreciated.
> 
> 

I've started tested this a bit on ARM now. The first things I noticed
are:

1. /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the output is to use 4-byte wchar_t; use of wchar_t values across objects may fail

(actually this one has been present since the first version that
stopped using recursive linking, I did 971a69db7dc0 ("Xen: don't
warn about 2-byte wchar_t in efi") when I first saw the bug, but
that fix no longer works and we have to do this differently

2. big-endian builds on ARM stopped working, I now get

22:53:02   CC      init/do_mounts_md.o
22:53:02   LD      init/mounts.o
/home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: init/do_mounts.o: compiled for a big endian system and target is little endian
/home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: failed to merge target specific data of file init/do_mounts.o

The problem seems to be that we don't pass the correct linker
flags any more, it should be using --be8 from

arch/arm/Makefile:LDFLAGS_vmlinux       += --be8
arch/arm/Makefile:LDFLAGS_MODULE        += --be8

but that somehow is lost.

3. drivers/firmware/efi/libstub/lib.a: error adding symbols: Archive has no index; run ranlib to add one

haven't investigated at all, turned off EFI for now.

	Arnd
