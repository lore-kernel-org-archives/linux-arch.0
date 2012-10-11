From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/4] uapi: Allow automatic generation of trivial headers
Date: Thu, 11 Oct 2012 17:46:40 +0100
Message-ID: <19626.1349974000@warthog.procyon.org.uk>
References: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758266Ab2JKQqo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Oct 2012 12:46:44 -0400
In-Reply-To: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> wrote:

> The asm/Kbuild allows automatic generation of header files by specifying
> "generic-y += ...". The first patch in the series allows the same thing
> to be specified in uapi/asm/Kbuild.
> 
> The subsequent patches remove some of the trivial header files in arm64,
> s390 and sparc. Please note that the series has only been tested on
> arm64. I can test the others but not until tomorrow.

It should be noted that the arm64 patch is dependent on the disintegrate-arm64
branch of my UAPI disintegration patches, which I don't believe is upstream
yet.

David
