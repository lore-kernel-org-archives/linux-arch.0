From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Mon, 30 Aug 2010 21:50:11 +0100
Message-ID: <26799.1283201411@redhat.com>
References: <4C7B59E1.6010904@snapgear.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122Ab0H3UuR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Aug 2010 16:50:17 -0400
In-Reply-To: <4C7B59E1.6010904@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Greg Ungerer <gerg@snapgear.com> wrote:

> I have no problem with the changes as such. But I would rather
> not have separate mm and no headers if we can avoid it.

Well, I can roll the headers into one, but then it'll be much more #ifdef'd if
you're okay with that.  The IRQ handling seems sufficiently different to
warrant that.

David
