From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 07/38] Delete unused Kbuild files in include/*
Date: Tue, 15 Jul 2014 10:06:35 +0100
Message-ID: <53C4EF1B.2050506@imgtec.com>
References: <20140714150609.GA28358@ravnborg.org> <1405350546-28467-1-git-send-email-sam@ravnborg.org> <1405350546-28467-7-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:25126 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584AbaGOJGi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:06:38 -0400
In-Reply-To: <1405350546-28467-7-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Howells <dhowells@redhat.com>

On 14/07/14 16:08, Sam Ravnborg wrote:
> The following files are not used - and they serve no purpose.
> Delete them.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  include/Kbuild         | 2 --
>  include/scsi/fc/Kbuild | 0
>  include/video/Kbuild   | 0
>  3 files changed, 2 deletions(-)
>  delete mode 100644 include/Kbuild
>  delete mode 100644 include/scsi/fc/Kbuild
>  delete mode 100644 include/video/Kbuild

include/asm-generic/Kbuild.asm could go too since it isn't included
anywhere.

Cheers
James
