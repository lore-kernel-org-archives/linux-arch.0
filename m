From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 15/21] powerpc: Use generic posix_types.h
Date: Thu, 16 Feb 2012 13:44:44 +0000
Message-ID: <3399.1329399884@redhat.com>
References: <1328677745-20121-16-git-send-email-hpa@zytor.com> <1328677745-20121-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab2BPNox (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 08:44:53 -0500
In-Reply-To: <1328677745-20121-16-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>


PowerPC exports __FD_SET() and co. to userspace under some circumstances,
therefore this patch potentially breaks the userspace ABI.  Is this okay, Ben?

David
