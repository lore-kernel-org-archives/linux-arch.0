Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56872 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbIKIry (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2015 04:47:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86: Wire up 32-bit direct socket calls
Date: Fri, 11 Sep 2015 10:46:26 +0200
Message-ID: <49726621.LPTnfQXYGz@wuerfel>
In-Reply-To: <20150911082429.GA12452@osiris>
References: <cb5138299d37d5800e2d135b01a7667fa6115854.1436912629.git.luto@kernel.org> <3193269.4TGcgnGPrm@wuerfel> <20150911082429.GA12452@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Network Development <netdev@vger.kernel.org>, Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, Cosimo Cecchi <cosimo@endlessm.com>, Dan Nicholson <nicholson@endlessm.com>, libc-alpha <libc-alpha@sourceware.org>, Rajalakshmi Srinivasaraghavan <raji@linux.vnet.ibm.com>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20150911084626.vzM9j_XUoTFCYsSOScvDR-fbEq9WDEACG_LOF4blGPw@z>

On Friday 11 September 2015 10:24:29 Heiko Carstens wrote:
> 
> FWIW, the s390 approach (ignoring the "new" system calls) is only temporarily.
> I'll enable the seperate calls later when I have time to test everything,
> especially the glibc stuff.

Ok, thanks for clarifying.

> The same is true for the ipc system call. (any reason why the seperate system
> calls haven't been enabled on x86 now as well?)

Agreed, we should split that out on all architectures as well.
Almost the same set of architectures that have sys_socketcall also
have sys_ipc, and the reasons for changing are identical. I don't
think we have any other system calls that are handled like this
on some architectures but not on others. There are a couple of
system calls (e.g. futex) that are also multiplexers, but at
least they do it consistently.

	Arnd
