From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Warning with asm-generic/div64.h
Date: Fri, 25 Mar 2011 14:39:53 +0100
Message-ID: <201103251439.53568.arnd@arndb.de>
References: <007801cbead6$1984b6e0$4c8e24a0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53598 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1CYNkB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Mar 2011 09:40:01 -0400
In-Reply-To: <007801cbead6$1984b6e0$4c8e24a0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 25 March 2011, Guan Xuetao wrote:
> Following warning is generated when using <asm-generic/div64.h>
> 
> kernel/power/hibernate.c: In function 'swsusp_show_speed':
> kernel/power/hibernate.c:227: warning: comparison of distinct pointer types lacks a cast
> 
> After expanding the do_div() macro, the problem line is:
> 
>         (void)(((typeof((n)) *)0) == ((uint64_t *)0));
> 
> while the type of n is s64.
> 
> I am puzzled with the usage of the problem line.
> 
> And how to correct it?

The purpose of this line is to generate a warning when the input is the
wrong type, as the comment says:
 /* The unnecessary pointer compare is there
  * to check for type safety (n must be 64bit)

The macro doesn't work for signed input or for 32 bit input. I'd suggest
fixing the caller to use an unsigned type.

	Arnd
