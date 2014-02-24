From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and family
Date: Mon, 24 Feb 2014 12:09:11 +0000
Message-ID: <10646.1393243751@warthog.procyon.org.uk>
References: <20140224084437.GG20680@thin> <20140222192325.GA12587@thin> <201402240902.35977.arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbaBXMJU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Feb 2014 07:09:20 -0500
In-Reply-To: <20140224084437.GG20680@thin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:

> > This means we actually want BUG() to end with __builtin_unreachable()
> > as in the CONFIG_BUG=y case, and also ensure it actually is
> > unreachable. As I have shown in [1], the there is a small overhead
> > of doing this in terms of code size.
> 
> I agree that allowing BUG() to become a no-op seems suboptimal, if only
> because of the resulting warnings and mis-optimizations.  However, I
> think the overhead could be cut down massively, such that BUG() just
> compiles down to a one-byte undefined instruction.  (__builtin_trap()
> might do the right thing here; worth checking.)

Is it possible to use an inline function with an empty body in this?  Let the
compiler prune away all the arguments?

David
