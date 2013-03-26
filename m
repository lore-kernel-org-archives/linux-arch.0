From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] UAPI: Remove empty Kbuild files
Date: Tue, 26 Mar 2013 21:27:14 +0000
Message-ID: <30061.1364333234@warthog.procyon.org.uk>
References: <20130326140520.3100447ee78322d52e6be7af@linux-foundation.org> <20130326131828.209aff73e38d3273d078bb2e@linux-foundation.org> <20130326174853.10144.36253.stgit@warthog.procyon.org.uk> <29647.1364331583@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3CZV1W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Mar 2013 17:27:22 -0400
In-Reply-To: <20130326140520.3100447ee78322d52e6be7af@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Obviously, I thought you were referring to build-time operations.

I want to know whether I should extend my patch to remove include/Kbuild and
any refs to it.

> > so I don't see the problem.
>
> Well damn.  I tested this a few days ago and a `make mrproper' didn't
> remove usr/include.  Did something change recently?  If not, something
> odd is going on.  I definitely tested it.

I haven't changed anything.

David
