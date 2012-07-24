Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109Ab2GXNT1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jul 2012 09:19:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHO5Pa0NOUk=Z8SNQ9t=Oi6aU96o-JtMuAytAoXJ2v1L0ntNww@mail.gmail.com>
References: <CAHO5Pa0NOUk=Z8SNQ9t=Oi6aU96o-JtMuAytAoXJ2v1L0ntNww@mail.gmail.com> <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH 00/13] UAPI header file split
Date: Tue, 24 Jul 2012 14:19:12 +0100
Message-ID: <28702.1343135952@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com
Message-ID: <20120724131912._4s0s3N97INuSkzvW_5-Eb6v92HnrtpwqymtUIJzf-E@z>

Michael Kerrisk <mtk.manpages@gmail.com> wrote:

> In the uapi-split branch, there are now 44 empty Kbuild files. Was
> that intended? Or, should these files rather be removed by your
> patches?

To be removed by a later patch, I think.  Getting rid of some of them isn't
trivial - ones in arch/x/include/asm/Kbuild for example - because that Kbuild
is referenced by common code IIRC as a function of the arch.

David
