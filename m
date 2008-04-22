Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:33610 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYDVPmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 11:42:17 -0400
Date: Tue, 22 Apr 2008 11:42:16 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Message-ID: <20080422154216.GI19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422152122.GF19802@phobos.i.cabal.ca> <200804221738.19635.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200804221738.19635.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080422154216.CywNInIXAy3qNehha3t0Tiuj-e9QDfbosSFanY01Fq0@z>

On Tue, Apr 22, 2008 at 05:38:19PM +0200, Arnd Bergmann wrote:
> On Tuesday 22 April 2008, Kyle McMartin wrote:
> > 
> > This should (imnsho, at least),
> >         1 - Add a cond_syscall for sys_sysfs to sys_ni.c
> >         2 - Use a CONFIG_EMBEDDED dependent option that defaults on,
> >             possibly depend on BLACKFIN if you really want to.
> > 
> > Adding this junk to every arch header is, in my opinion, completely
> > unacceptable just because blackfin wants to be different.
> 
> It's not that they want to be different, but rather that I (among others)
> requested that they don't implement obsolete syscalls, so they removed it
> from their syscall table.
> 

Ah, I stupidly assumed sys_sysfs was something to do with /sys.

regards, Kyle
