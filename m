From: David Howells <dhowells@redhat.com>
Subject: Re: PROC macro to annotate functions in assembly files
Date: Wed, 17 Dec 2008 10:53:53 +0000
Message-ID: <1636.1229511233@redhat.com>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43192 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbYLQKyT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Dec 2008 05:54:19 -0500
In-Reply-To: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>

Alexander van Heukelum <heukelum@fastmail.fm> wrote:

> The goal is to annotate functions, at least those called
> from C code, with PROC at the beginning and ENDPROC at the
> end. This is for the benefit of debugging and tracing.

What about asm functions that have multiple entry points?

Take arch/mn10300/mm/cache-flush-mn10300.S for example.  Several functions in
there share bodies by virtue of falling through one to another.

David
