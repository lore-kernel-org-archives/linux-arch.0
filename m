Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbdLHWZC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Dec 2017 17:25:02 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171208221439.ucfahr4gvv77jnsd@agluck-desk>
References: <20171208221439.ucfahr4gvv77jnsd@agluck-desk> <3908561D78D1C84285E8C5FCA982C28F7B2CC912@ORSMSX110.amr.corp.intel.com> <151274828931.9961.17801232134228415862.stgit@warthog.procyon.org.uk> <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <10175.1512748454@warthog.procyon.org.uk> <31453.1512759888@warthog.procyon.org.uk>
Subject: Re: Does this break IA64 Linux?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4634.1512771897.1@warthog.procyon.org.uk>
Date: Fri, 08 Dec 2017 22:24:57 +0000
Message-ID: <4635.1512771897@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: dhowells@redhat.com, "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20171208222457.xbYgKJ6Di5IeDKgV4C0915TvzNdClN95iOm1UDT0yQY@z>

Luck, Tony <tony.luck@intel.com> wrote:

> I pulled this branch and it builds on all of my ia64 test
> configurations. Boots too.
> 
> So no ia64 breakage.

Excellent, thanks!  Can I put you down as a Tested-by?

David
