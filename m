From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [kernel-hardening] Re: [RFC v2] implement SL*B and stack
 usercopy runtime checks
Date: Tue, 19 Jul 2011 11:40:43 +0400
Message-ID: <20110719074043.GA3942@albatros>
References: <20110703111028.GA2862@albatros>
 <CA+55aFzXEoTyK0Sm-y=6xGmLMWzQiSQ7ELJ2-WL_PrP3r44MSg@mail.gmail.com>
 <20110718183951.GA3748@albatros>
 <20110718115237.14d96c03.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53499 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab1GSHku (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2011 03:40:50 -0400
Content-Disposition: inline
In-Reply-To: <20110718115237.14d96c03.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Mon, Jul 18, 2011 at 11:52 -0700, Andrew Morton wrote:
> > +noinline bool __kernel_access_ok(const void *ptr, unsigned long len)
> 
> noinline seems unneeded

Ah, understood what you mean.  It is .c, and users are in other .c, so
it is indeed redundant.

Thanks!

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
