From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 13/21] mn10300: Use generic posix_types.h
Date: Thu, 16 Feb 2012 13:44:00 +0000
Message-ID: <3355.1329399840@redhat.com>
References: <1328677745-20121-14-git-send-email-hpa@zytor.com> <1328677745-20121-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50371 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab2BPNoO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 08:44:14 -0500
In-Reply-To: <1328677745-20121-14-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>

H. Peter Anvin <hpa@zytor.com> wrote:

> Change the mn10300 architecture to use <asm-generic/posix_types.h>.

MN10300 exports __FD_SET() and co. to userspace under some circumstances,
therefore this patch potentially breaks the userspace ABI.

David
