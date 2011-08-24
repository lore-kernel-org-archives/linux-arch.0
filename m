From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
Date: Wed, 24 Aug 2011 10:25:37 -0500
Message-ID: <20110824152537.GA3993@codeaurora.org>
References: <20110822193602.GA23301@codeaurora.org>
 <2047151.mWElcT8jZQ@wuerfel>
 <1314151284.29738.34.camel@epip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15342 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1HXP0D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2011 11:26:03 -0400
Content-Disposition: inline
In-Reply-To: <1314151284.29738.34.camel@epip-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>

On Wed, Aug 24, 2011 at 10:01:24AM +0800, Guan Xuetao wrote:
>   For getdents (or other deprecated syscalls), we select getdents64 to
> replace getdent, though we have not verified it on unicore32 platform.

Do you have a publically-available version? Have you considered
submitting it to the FSF?  Have you signed the copyright-transfer
forms with the FSF?

My goal with the hexagon archiecture is to have the kernel asm/unistd.h
include asm-generic/unistd.h, and have glibc compile (on hexagon) with
no further #defines in asm/unistd.h.  This "almost" works today; with
Chris Metcalf's generic syscall patches for glibc, I am able to compile
glibc (and pass the glibc test suite). However, I have to #define
__ARCH_WANT_SYSCALL_DEPRECATED to do this. If I don't, then the 
getdents syscall fails to compile; I don't know how many others there are.

As to the "API": I just want to use Arnd's "generic" kernel support;
that will be the API.  No changing, porting, hacking :-)

-- Linas

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
