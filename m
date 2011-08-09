From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 15/24] C6X: cache control
Date: Tue, 09 Aug 2011 18:03:16 +0100
Message-ID: <12886.1312909396@redhat.com>
References: <201108091853.54655.arnd@arndb.de> <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-16-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35315 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011Ab1HIRDX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Aug 2011 13:03:23 -0400
In-Reply-To: <201108091853.54655.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Mark Salter <msalter@redhat.com>, linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > +#define IMCR_BASE	  0x01840000
> 
> Please don't hardcode MMIO regions like this. You should have the base
> address in the device tree and use of_iomap() like you do in some other
> cases.  If you need this really early, you might need to

What about for memory-mapped CPU registers that you might need to access in
head.S?

MN10300, for example, has a bunch of these - such the atomic operation
parameter and control registers.  Getting some of these through the device
tree adds potentially quite a lot of overhead.

David
