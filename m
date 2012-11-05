From: David Howells <dhowells@redhat.com>
Subject: Re: tools, perf: Fix up for x86 UAPI disintegration
Date: Mon, 05 Nov 2012 22:53:27 +0000
Message-ID: <25722.1352156007@warthog.procyon.org.uk>
References: <15094.1352155791@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2KEWxo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 5 Nov 2012 17:53:44 -0500
In-Reply-To: <15094.1352155791@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: dhowells@redhat.com, mingo@kernel.org, tglx@linutronix.de, acme@ghostprotocols.net, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

David Howells <dhowells@redhat.com> wrote:

> I've posted a revised version of my perf patches to my UAPI disintegration GIT
> tree.

Hmmm...  It seems to break some things according to Fengguang's kbuild test
robot.

David
