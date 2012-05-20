Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56680 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab2ETCJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 May 2012 22:09:04 -0400
Message-ID: <4FB85222.9040909@kernel.org>
Date: Sat, 19 May 2012 19:08:34 -0700
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <CA+55aFzfku-5qgVPahu27DLz-y8MUmh7Mw9sq_TyO49Zb0tg=A@mail.gmail.com> <CAMe9rOr883q0OAsh+JGA83ww603y6QSbQJKx+wk2YJfkYcaEdQ@mail.gmail.com> <201205182121.02706.arnd@arndb.de> <4FB83123.3020402@zytor.com> <CAMe9rOrKWTFPdFzdN5d6_zR9bPs8Td-oFgs4ObypbB_sd3GovA@mail.gmail.com>
In-Reply-To: <CAMe9rOrKWTFPdFzdN5d6_zR9bPs8Td-oFgs4ObypbB_sd3GovA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>, David Howells <dhowells@redhat.com>
Message-ID: <20120520020834.qynCGO9LxNfrVD44vkNrCexG3t_fBygjq56z1g3Lzk8@z>

On 05/19/2012 06:32 PM, H.J. Lu wrote:
> 
> If __BITS_PER_LONG is set to 32 for x32, we need to audit all
> exported kernel headers where __BITS_PER_LONG is checked.
> If long is used in those places, it has to be updated for x32.
> 

I think we have to do that anyway.

	-hpa
