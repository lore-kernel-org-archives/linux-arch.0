From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 20/21] xtensa: Use generic posix_types.h
Date: Thu, 16 Feb 2012 13:42:59 +0000
Message-ID: <3289.1329399779@redhat.com>
References: <1328677745-20121-21-git-send-email-hpa@zytor.com> <1328677745-20121-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab2BPNnG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 08:43:06 -0500
In-Reply-To: <1328677745-20121-21-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Chris Zankel <chris@zankel.net>


Xtensa exports __FD_SET() and co. to userspace under some circumstances,
therefore this patch potentially breaks the userspace ABI.

David
