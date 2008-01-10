Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60291 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbYAJNBw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Jan 2008 08:01:52 -0500
Date: Thu, 10 Jan 2008 14:01:34 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + asm-posix_typesh-scrub-__glibc__.patch added to -mm tree
Message-ID: <20080110130134.GA22103@elte.hu>
References: <200801100805.m0A851jS012049@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200801100805.m0A851jS012049@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, vapier@gentoo.org, drepper@redhat.com, linux-arch@vger.kernel.org, roland@redhat.com


* akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:

> The patch titled
>      asm-*/posix_types.h: scrub __GLIBC__
> has been added to the -mm tree.  Its filename is
>      asm-posix_typesh-scrub-__glibc__.patch
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: asm-*/posix_types.h: scrub __GLIBC__
> From: Mike Frysinger <vapier@gentoo.org>
> 
> Some arches (like alpha and ia64) already have a clean posix_types.h header.
> This brings all the others in line by removing all references to __GLIBC__
> (and some undocumented __USE_ALL).
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Ulrich Drepper <drepper@redhat.com>
> Cc: Roland McGrath <roland@redhat.com>

iirc Roland commented on this patch (positively).

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
