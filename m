From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 2/4] byteorder: wire up the arches to use the new
 headers
Date: Sat, 24 May 2008 17:43:00 +0200
Message-ID: <20080524174300.6141f96c@hskinnemo-gx745.norway.atmel.com>
References: <1211580536.6888.44.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:59935 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbYEXQnS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 24 May 2008 12:43:18 -0400
Received: from bagnes.atmel.com ([10.175.100.4])
	by sjogate2.atmel.com (8.13.6/8.13.6) with ESMTP id m4OG5gaX010688
	for <linux-arch@vger.kernel.org>; Sat, 24 May 2008 09:05:44 -0700 (PDT)
In-Reply-To: <1211580536.6888.44.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Harvey Harrison <harvey.harrison@gmail.com> wrote:
> -#ifdef __CHECKER__
> -extern unsigned long __builtin_bswap_32(unsigned long x);
> -extern unsigned short __builtin_bswap_16(unsigned short x);
> -#endif

Why did you remove this? Sparse tends to complain a lot when we're
calling builtins it doesn't know about...

> -/*
> - * avr32-linux-gcc versions earlier than 4.2 improperly sign-extends
> - * the result.
> - */
> -#if !(__GNUC__ == 4 && __GNUC_MINOR__ < 2)

I'd also prefer not reintroducing subtle code generation bugs deep in
the ext2 filesystem...

It could be that using inlines instead of macros may cover up this bug,
but I wouldn't count on it. So please make sure that we fall back to
the default, non-optimized implementation for gcc versions earlier than
4.2.

Haavard
