From: David Howells <dhowells@redhat.com>
Subject: Re: cmpxchg and x86 flags output
Date: Wed, 22 Jun 2016 17:11:34 +0100
Message-ID: <16238.1466611894@warthog.procyon.org.uk>
References: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com> <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com> <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com> <20160615085002.GC30935@twins.programming.kicks-ass.net> <4467.1466499980@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49416 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbcFVQLg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 12:11:36 -0400
In-Reply-To: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com>
Content-ID: <16237.1466611893.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

H. Peter Anvin <hpa@zytor.com> wrote:

> The question for me is for things like lock patching that we do on x86...

This might be pertinent to what you're asking:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70973

David
