Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:59842 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935Ab1HYCdi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Aug 2011 22:33:38 -0400
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
In-Reply-To: <20110824152537.GA3993@codeaurora.org>
References: <20110822193602.GA23301@codeaurora.org>
	 <2047151.mWElcT8jZQ@wuerfel> <1314151284.29738.34.camel@epip-laptop>
	 <20110824152537.GA3993@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Aug 2011 10:33:42 +0800
Message-ID: <1314239622.29738.53.camel@epip-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20110825023342.XeehpXCWh59UsITT8xyNZPNN6XptwuL-CAMwcwhpoKM@z>

On Wed, 2011-08-24 at 10:25 -0500, Linas Vepstas (Code Aurora) wrote:
> On Wed, Aug 24, 2011 at 10:01:24AM +0800, Guan Xuetao wrote:
> >   For getdents (or other deprecated syscalls), we select getdents64 to
> > replace getdent, though we have not verified it on unicore32 platform.
> 
> Do you have a publically-available version? Have you considered
> submitting it to the FSF?  Have you signed the copyright-transfer
> forms with the FSF?
Firstly, what I said for getdents64 in unicore is just in developing,
not ready yet.
And for glibc part, it need much time to prepare for submitting.

> 
> My goal with the hexagon archiecture is to have the kernel asm/unistd.h
> include asm-generic/unistd.h, and have glibc compile (on hexagon) with
> no further #defines in asm/unistd.h.  This "almost" works today; with
> Chris Metcalf's generic syscall patches for glibc, I am able to compile
> glibc (and pass the glibc test suite). However, I have to #define
> __ARCH_WANT_SYSCALL_DEPRECATED to do this. If I don't, then the 
> getdents syscall fails to compile; I don't know how many others there are.
It's also my goal. And you have walked further than me.
I guess, Chris don't need getdent for tile, since he didn't export the
syscall in kernel.
IMO, it's better to add one syscall instead of
__ARCH_WANT_SYSCALL_DEPRECATED in your own unistd.h:

#define __NR_getdents 1065
#define __ARCH_WANT_SYS_GETDENTS
__SYSCALL(__NR_getdents, sys_getdents)

> 
> As to the "API": I just want to use Arnd's "generic" kernel support;
> that will be the API.  No changing, porting, hacking :-)
> 
> -- Linas
> 

Regards

Guan Xuetao

