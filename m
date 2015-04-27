Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65278 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbbD0Hj3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Apr 2015 03:39:29 -0400
Message-ID: <553DE7A8.8060706@nod.at>
Date: Mon, 27 Apr 2015 09:39:20 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/10] an introduction of Linux library operating system
 (LibOS)
References: <1429450104-47619-1-git-send-email-tazaki@sfc.wide.ad.jp> <1430103618-10832-1-git-send-email-tazaki@sfc.wide.ad.jp> <553DE54D.9030301@nod.at>
In-Reply-To: <553DE54D.9030301@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <tazaki@sfc.wide.ad.jp>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>, Jekka Enberg <penberg@kernel.org>, Javid Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Jndrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Ryo Nakamura <upa@haeena.net>, Christoph Paasch <christoph.paasch@gmail.com>, Mathieu Lacage <mathieu.lacage@gmail.com>, libos-nuse@googlegroups.com
Message-ID: <20150427073920.7cNX3Y0XWUwR1yx6jA1eg_12w6JBnXH-zXe7K7iZv6w@z>

Am 27.04.2015 um 09:29 schrieb Richard Weinberger:
> Hi!
> 
> Am 27.04.2015 um 05:00 schrieb Hajime Tazaki:
>> This is the 4th version of Linux LibOS patchset which reflects a
>> couple of comments received from people.
>>
>> changes from v3:
>> - Patch 09/10 ("lib: libos build scripts and documentation")
>> 1) Remove RFC (now it's a proposal)
>> 2) build environment cleanup (commented by Paul Bolle)
>> - Overall
>> 3) change based tree from arnd/asm-generic to torvalds/linux.git
>>    (commented by Richard Weinberger)
>> 4) rebased to Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
> 
> Hmm, it still does not build. This time I got:
> 
>   CC      kernel/time/time.o
> In file included from kernel/time/time.c:44:0:
> kernel/time/timeconst.h:11:2: error: #error "kernel/timeconst.h has the wrong HZ value!"
>  #error "kernel/timeconst.h has the wrong HZ value!"
>   ^
> arch/lib/Makefile:187: recipe for target 'kernel/time/time.o' failed
> make: *** [kernel/time/time.o] Error 1

A make mrproper made the issue go away.
Please use kbuild. :)

Thanks,
//richard
