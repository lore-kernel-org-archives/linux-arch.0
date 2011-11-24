From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/2] Stop some of the abuse of BUG() where compile time
 checks should be used.
Date: Thu, 24 Nov 2011 10:31:45 -0800
Message-ID: <CA+55aFx9x7Q0urXJHk7g2Fxqot0J=9YxaWcdmduwy=sm0DOduA@mail.gmail.com>
References: <1322092017-21471-1-git-send-email-ddaney.cavm@gmail.com>
 <CA+55aFwjUVhff6jADOSvAn=t4CTVf4ZODTNm7M6vYcmG6TikPA@mail.gmail.com>
 <4ECD91E4.5090504@gmail.com> <20469.1322130295@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab1KXScI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2011 13:32:08 -0500
In-Reply-To: <20469.1322130295@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, David Rientjes <rientjes@google.com>, DM <dm.n9107@gmail.com>, David Daney <david.daney@cavium.com>, "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>

On Thu, Nov 24, 2011 at 2:24 AM, David Howells <dhowells@redhat.com> wrote:
>
> Have you tried asking the gcc folks if this is likely to get fixed soon?

I actually don't think it's a bug. The error message is associated
with the function declaration symbol, so it actually makes sense that
there can be only one error message per callee - not per caller.

Using "__LINE__" to then create fairly unique symbols (modulo
#include, of course) gets around it in a pretty natural way as ddaney
said, so if we care enough.  I don't think it's a big issue (as
mentioned, I'd worry more about us making sure it's reliable enough to
be used - we've had gcc sometimes fail to compile things out just
because some optimization was not working well enough).

               Linus
