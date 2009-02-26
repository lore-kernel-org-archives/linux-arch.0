From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned long [frv]
Date: Thu, 26 Feb 2009 01:37:48 +0000
Message-ID: <9679.1235612268@redhat.com>
References: <49A5E876.1000501@zytor.com> <49A5C754.7000408@zytor.com> <200902250452.UAA12902@hpdst41.cup.hp.com> <16693.1235565430@redhat.com> <7355.1235605851@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52251 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbZBZBjx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 20:39:53 -0500
In-Reply-To: <49A5E876.1000501@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:

> > But how does it break down between "static inline type\nfunction_name" and
> > "static inline\ntype function_name"?  That's more to the point.
> >
> 
> I believe that is the breakdown is roughly what you see above, i.e. over 8:1;
> the pattern I used was looking for "^static inline[^;(]*$", and a visual
> examination of the results shows that even if my line count is slighly off the
> lopsidedness is still dramatic.

Sorry, I meant:

"static inline type\nfunction_name" vs "static inline type function_name"

David
