Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172Ab2CMKBs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Mar 2012 06:01:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <201203130916.15118.arnd@arndb.de>
References: <201203130916.15118.arnd@arndb.de> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233747.13888.75605.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH 10/35] Disintegrate asm/system.h for Hexagon [ver #2]
Date: Tue, 13 Mar 2012 10:01:40 +0000
Message-ID: <27808.1331632900@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org
Message-ID: <20120313100140.aTRADz1r8IjDse6Xjbsov5u8i6tnSAKtrSRvM1fUzv0@z>

Arnd Bergmann <arnd@arndb.de> wrote:

> Looking at this example, it could easily use the asm-generic versions of
> switch_to.h and barrier.h, but that would complicate the dependency chain
> again.

Yep.  The plan is to throw more patches on to the end of the series to
consolidate those.

In fact, I wonder if we still really need the switch_to() macro wrapper, or
whether we could replace it with an function, inline or otherwise, that
returns the macro's third argument.

David
