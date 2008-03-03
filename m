Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761498AbYCCK5p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Mar 2008 05:57:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Mon, 03 Mar 2008 10:57:32 +0000
Message-ID: <8260.1204541852@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303105732.wEAegrKtKvccRA5e8jJvpJbY6ZtUFpIaEfF8mBzeBlc@z>

H. Peter Anvin <hpa@zytor.com> wrote:

> +#define S8_C(x)	 x
> +#define U8_C(x)  x ## U
> +#define S16_C(x) x
> +#define U16_C(x) x ## U
> +#define S32_C(x) x
> +#define U32_C(x) x ## U
> +#define S64_C(x) x ## LL
> +#define U64_C(x) x ## ULL

And #if defined(__ASSEMBLY__), just splat x through as is.

David
