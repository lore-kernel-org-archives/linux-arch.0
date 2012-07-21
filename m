From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 05/13] UAPI: Partition the header include path sets and add uapi/ header directories
Date: Sat, 21 Jul 2012 10:41:11 +0100
Message-ID: <1256.1342863671@warthog.procyon.org.uk>
References: <20120720215738.14854.55273.stgit@warthog.procyon.org.uk> <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2GUJlb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Jul 2012 05:41:31 -0400
In-Reply-To: <20120720215738.14854.55273.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com

David Howells <dhowells@redhat.com> wrote:

> +		-Iinclude/uapi \

This needs prefacing with $(srctree)/.  I got it right in the commit message
but not in the patch.  Thanks to Fengguang Wu for finding it with his kernel
cruncher.

David
