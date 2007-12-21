Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55195 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbXLUM4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2007 07:56:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -mm 05/43] compat_binfmt_elf
Date: Fri, 21 Dec 2007 13:55:04 +0100
References: <20071220115200.C767E26F98A@magilla.localdomain> <20071220115447.4F8E326F98A@magilla.localdomain>
In-Reply-To: <20071220115447.4F8E326F98A@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200712211355.05173.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 20 December 2007, Roland McGrath wrote:
> This adds fs/compat_binfmt_elf.c, a wrapper around fs/binfmt_elf.c for
> 32-bit ELF support on 64-bit kernels.  It can replace all the hand-rolled
> versions of this that each 32/64 arch has, which are all about the same.

Great stuff! I've attempted to do this a few times over the past years,
but could never get my head around it. One more bit of broken compat
code gone from the architectures!

	Arnd <><
