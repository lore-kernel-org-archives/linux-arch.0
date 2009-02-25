From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned long [frv]
Date: Wed, 25 Feb 2009 23:50:51 +0000
Message-ID: <7355.1235605851@redhat.com>
References: <49A5C754.7000408@zytor.com> <200902250452.UAA12902@hpdst41.cup.hp.com> <16693.1235565430@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55664 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbZBYXw7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 18:52:59 -0500
In-Reply-To: <49A5C754.7000408@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:

> What makes you say that, in particular?

I prefer it.  Actually, I'd prefer it all to be on one line, but some people
get picky about the 80 char limit.

Besides, that "static inline" is merely a qualifier to the declaration of the
function.  The return type, name and args are part of the declaration of the
function and belong together more.

> A casual grep finds no less than 3524 instances of "static inline <type>" --
> presumably with a function name following -- and only 447 instances of
> "static inline" without a type in the kernel.

But how does it break down between "static inline type\nfunction_name" and
"static inline\ntype function_name"?  That's more to the point.

David
