From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/4] uapi: Allow automatic generation of trivial headers
Date: Thu, 11 Oct 2012 17:52:20 +0100
Message-ID: <20121011165220.GD10659@arm.com>
References: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
 <19626.1349974000@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50823 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755Ab2JKQwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2012 12:52:25 -0400
In-Reply-To: <19626.1349974000@warthog.procyon.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 11, 2012 at 05:46:40PM +0100, David Howells wrote:
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > The asm/Kbuild allows automatic generation of header files by specifying
> > "generic-y += ...". The first patch in the series allows the same thing
> > to be specified in uapi/asm/Kbuild.
> > 
> > The subsequent patches remove some of the trivial header files in arm64,
> > s390 and sparc. Please note that the series has only been tested on
> > arm64. I can test the others but not until tomorrow.
> 
> It should be noted that the arm64 patch is dependent on the disintegrate-arm64
> branch of my UAPI disintegration patches, which I don't believe is upstream
> yet.

Not yet. But this series is not meant for this merging window anyway.

-- 
Catalin
