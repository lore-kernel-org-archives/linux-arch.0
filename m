From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] Reduce get_current() to the asm-generic implementation where possible
Date: Fri, 21 May 2010 11:13:23 +0100
Message-ID: <22710.1274436803@redhat.com>
References: <20100518194753.GA2318@shareable.org> <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab0EUKNf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 May 2010 06:13:35 -0400
In-Reply-To: <20100518194753.GA2318@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: dhowells@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:

> Last time I looked, GCC didn't seem to do anything useful with the
> const attribute on inline functions.  I.e. no elimination of duplicate calls.

That's something that may change in the future.  It doesn't hurt to have it as
far as I can see.

David
