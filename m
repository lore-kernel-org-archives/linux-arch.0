From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 00:35:32 +0000
Message-ID: <24705.1323909332@redhat.com>
References: <CA+55aFzanrQU2DQHxkE7cWBOwT7Xb=+LfmSNWoatDL-oiV6opA@mail.gmail.com> <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396Ab1LOAfn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Dec 2011 19:35:43 -0500
In-Reply-To: <CA+55aFzanrQU2DQHxkE7cWBOwT7Xb=+LfmSNWoatDL-oiV6opA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm nervous about making this change even on x86-64 unless we add big
> comments about the old 32-bit change.

Are you happy with patches 2 and 3?  I can always split the set into two as
the 2nd and 3rd are really independent of the 1st.

David
