From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h numbers in brackets
Date: Mon, 25 Oct 2010 16:59:30 +0100
Message-ID: <30620.1288022370@redhat.com>
References: <4CC5A748.6050903@zytor.com> <4CC5B1A1020000780001EF7C@vpn.id2.novell.com> <20101025140218.5092.74117.stgit@warthog.procyon.org.uk> <28707.1288018465@redhat.com> <4CC5B8D3020000780001EFB4@vpn.id2.novell.com> <AANLkTi=mpKRQgZp5zCoCsBtkuWHrpkOq2Zch-OOGu4CC@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35498 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab0JYP7v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2010 11:59:51 -0400
In-Reply-To: <4CC5A748.6050903@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Alexander van Heukelum <heukelum@fastmail.fm>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:

> As such, the only options I can really think about overriding the sed
> expression for x86 or just saying gcc 2.16.90 or later is required...

Do you mean binutils-2.16.90?

Davod
