From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] Adjust the comment on get_order() to describe the size==0 case
Date: Tue, 20 Dec 2011 15:39:25 +0000
Message-ID: <14925.1324395565@redhat.com>
References: <201112201509.21334.arnd@arndb.de> <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <20111213145704.14362.62471.stgit@warthog.procyon.org.uk> <4EEF8652.5060201@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab1LTPjg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Dec 2011 10:39:36 -0500
In-Reply-To: <201112201509.21334.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> I generally prefer asm-generic patches to go through the trees that are
> most interested in them (with my ack), which keeps the series close together
> and lets me not maintain a separate tree for asm-generic most of the time.

Should I resubmit the latter two patches detached from the first with the
Acked-bys added?

David
