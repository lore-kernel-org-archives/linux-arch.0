From: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Mon, 13 Dec 2010 16:29:11 +0900
Message-ID: <9580.1292225351@jrobl>
References: <20101209070938.GA3949@amd> <19324.1291990997@jrobl> <20101213014553.GA6522@amd>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:39002 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0LMHh2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2010 02:37:28 -0500
In-Reply-To: <20101213014553.GA6522@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org


Nick Piggin:
> It's not scaling but just single threaded performance. gcc turns memcmp
> into rep cmp, which has quite a long latency, so it's not appripriate
> for short strings.

Honestly speaking I doubt how this 'long *' approach is effective
(Of course it never means that your result (by 'char *') is doubtful).
But is the "rep cmp has quite a long latency" issue generic for all x86
architecture, or Westmere system specific?


J. R. Okajima
