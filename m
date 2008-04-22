Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57391 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbYDVPi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 11:38:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 17:38:19 +0200
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422152122.GF19802@phobos.i.cabal.ca>
In-Reply-To: <20080422152122.GF19802@phobos.i.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200804221738.19635.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080422153819.wrYEmW28cMjZNmN_FhN3WvWkIFnrpEyMqrO8qJ-qLZ4@z>

On Tuesday 22 April 2008, Kyle McMartin wrote:
> 
> This should (imnsho, at least),
>         1 - Add a cond_syscall for sys_sysfs to sys_ni.c
>         2 - Use a CONFIG_EMBEDDED dependent option that defaults on,
>             possibly depend on BLACKFIN if you really want to.
> 
> Adding this junk to every arch header is, in my opinion, completely
> unacceptable just because blackfin wants to be different.

It's not that they want to be different, but rather that I (among others)
requested that they don't implement obsolete syscalls, so they removed it
from their syscall table.

	Arnd <><
