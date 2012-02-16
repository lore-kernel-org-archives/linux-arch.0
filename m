From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/21] powerpc: Use generic posix_types.h
Date: Fri, 17 Feb 2012 07:26:37 +1100
Message-ID: <1329423997.2892.20.camel@pasglop>
References: <1328677745-20121-16-git-send-email-hpa@zytor.com>
	 <1328677745-20121-1-git-send-email-hpa@zytor.com>
	 <3399.1329399884@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42210 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2BPU0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 15:26:47 -0500
In-Reply-To: <3399.1329399884@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Paul Mackerras <paulus@samba.org>

On Thu, 2012-02-16 at 13:44 +0000, David Howells wrote:
> PowerPC exports __FD_SET() and co. to userspace under some circumstances,
> therefore this patch potentially breaks the userspace ABI.  Is this okay, Ben?

I don't know why we would need that in userspace, unless some tools I
don't know about exploit them (hint: there shouldn't be)

I'm happy to remove them and see if anybody complains.

Cheers,
Ben.
