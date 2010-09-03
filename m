From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 3/3] Fix M68K irqflags
Date: Fri, 3 Sep 2010 16:53:23 +1000
Message-ID: <4C809B63.2040802@snapgear.com>
References: <4C804F3A.8020001@snapgear.com> <19747.1283422807@redhat.com> <20100902102203.19806.39028.stgit@warthog.procyon.org.uk> <7077.1283496259@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:59747 "HELO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752227Ab0ICGxy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2010 02:53:54 -0400
In-Reply-To: <7077.1283496259@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells wrote:
> Greg Ungerer <gerg@snapgear.com> wrote:
> 
>>>  -	DEFINE(THREAD_SIZE, THREAD_SIZE);
>>> -
>> This breaks final link due to missing THREAD_SIZE definition in head.S:
>>
>>   LD      vmlinux
>> arch/m68knommu/platform/coldfire/head.o: In function `_clear_bss':
>> (.head.text+0xa4): undefined reference to `THREAD_SIZE'
>>
>>
>> Without that asm-offsets.c change it works on my ColdFire boards.
>> I am happy with it:
> 
> With that, I get a duplicate reference to THREAD_SIZE.  head.S should include
> asm/thread_info.h rather than THREAD_SIZE being redefined in asm-offsets.
> 
>   CC      init/do_mounts_rd.o
> In file included from /warthog/nfs/linux-2.6-fscache/arch/m68k/include/asm/asm-offsets.h:1,
>                  from arch/m68knommu/platform/coldfire/entry.S:36:
> include/generated/asm-offsets.h:46:1: warning: "THREAD_SIZE" redefined
> In file included from /warthog/nfs/linux-2.6-fscache/arch/m68k/include/asm/thread_info.h:2,
>                  from arch/m68knommu/platform/coldfire/entry.S:32:
> /warthog/nfs/linux-2.6-fscache/arch/m68k/include/asm/thread_info_no.h:27:1: warning: this is the location of the previous definition

Yes, I get that too. I just hadn't tracked down why that was yet.


> Unfortunately, I don't have a binutils that can handle the funny Coldfire
> instructions.  Can you point me at a Coldfire toolchain?

This is what I currently use:

http://www.uclinux.org/pub/uClinux/m68k-elf-tools/tools-20080626/m68k-uclinux-tools-20080626.sh

Its just a binutils-2.18 and gcc-4.2.4 configured for m68k-uclinux
target.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
