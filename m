Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:53208 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160995AbcFGVYd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2016 17:24:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/9] generic syscalls: wire up memory protection keys syscalls
Date: Tue, 07 Jun 2016 23:25:20 +0200
Message-ID: <4151348.Xje1rehFl0@wuerfel>
In-Reply-To: <20160607204725.A731CB1E@viggo.jf.intel.com>
References: <20160607204712.594DE00A@viggo.jf.intel.com> <20160607204725.A731CB1E@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160607212520.j1gMEnB1i-LNMxMOvwZ5OclGfKpdpiww-YTXjdPGsDI@z>

On Tuesday, June 7, 2016 1:47:25 PM CEST Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> These new syscalls are implemented as generic code, so enable
> them for architectures like arm64 which use the generic syscall
> table.
> 
> According to Arnd:
> 
>         Even if the support is x86 specific for the forseeable
>         future, it may be good to reserve the number just in
>         case.  The other architecture specific syscall lists are
>         usually left to the individual arch maintainers, most a
>         lot of the newer architectures share this table.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
