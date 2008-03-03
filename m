Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58581 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYCCRFA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 12:05:00 -0500
Message-ID: <47CC2F67.80003@zytor.com>
Date: Mon, 03 Mar 2008 09:03:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <8260.1204541852@redhat.com> <20080303114310.GA28139@flint.arm.linux.org.uk> <20080303124050.GA24841@uranus.ravnborg.org>
In-Reply-To: <20080303124050.GA24841@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303170335.tb-BjfuHJ9ruFE2v8dFekViRHZdypZPbKhkOmCzgNBM@z>

Sam Ravnborg wrote:
> 
> And in linux/const.h we have yet another variant:
> /* Some constant macros are used in both assembler and
>  * C code.  Therefore we cannot annotate them always with
>  * 'UL' and other type specifiers unilaterally.  We
>  * use the following macros to deal with this.
>  *
>  * Similarly, _AT() will cast an expression with a type in C, but
>  * leave it unchanged in asm.
>  */
> 
> #ifdef __ASSEMBLY__
> #define _AC(X,Y)        X
> #define _AT(T,X)        X
> #else
> #define __AC(X,Y)       (X##Y)
> #define _AC(X,Y)        __AC(X,Y)
> #define _AT(T,X)        ((T)(X))
> #endif
> 
> Not as typestrict as hpa's and arm's version but
> used in a few placed already.
> 

These, unfortunately, don't solve the issue of gcc warnings, and you 
don't want to make them paste ULL on before the cast, since I think 
they're used with non-simple constants.

	-hpa
