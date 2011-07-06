From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/35] UAPI header file split
Date: Wed, 06 Jul 2011 12:04:46 +0100
Message-ID: <28657.1309950286@redhat.com>
References: <20110705134621.927b76e4.rdunlap@xenotime.net> <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab1GFLEu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jul 2011 07:04:50 -0400
In-Reply-To: <20110705134621.927b76e4.rdunlap@xenotime.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org

Randy Dunlap <rdunlap@xenotime.net> wrote:

> I didn't see patch 02/35 nor patch 30/35.
> Were they too large to be posted?

Well, too large to go through the linux-arch list.  They are both script
produced:

[PATCH 02/35] UAPI: Audit drivers/gpu/ for #include "..." referring to system headers
[PATCH 30/35] UAPI: Set up UAPI Kbuild files

The first is >4800 lines and the second is >7800 lines.

They are in GIT:

http://git.infradead.org/users/dhowells/linux-headers.git/commit/c748988cf4f4fe34f609e122f4af5e1274b9b8af

http://git.infradead.org/users/dhowells/linux-headers.git/commit/57685bc646eb0da571faf7b8f50bd5acd22a229f

David
