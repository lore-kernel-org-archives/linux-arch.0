From: David Howells <dhowells@redhat.com>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sun, 19 Sep 2010 07:50:21 +0100
Message-ID: <9520.1284879021@redhat.com>
References: <AANLkTin001qXMjqPjQxsHOD3xwvxh3YnOmEJmsyMa=yb@mail.gmail.com> <4C95324B.2030707@mcgary.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab0ISGua (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Sep 2010 02:50:30 -0400
In-Reply-To: <AANLkTin001qXMjqPjQxsHOD3xwvxh3YnOmEJmsyMa=yb@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: dhowells@redhat.com, Greg McGary <greg@mcgary.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:

> Forgive my ignorence, but is there something fundamentally wrong with
> having 48-bit longs?

48 is not a power of 2.  I wonder what that might break...

David
