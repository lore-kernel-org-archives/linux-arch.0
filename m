From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH 1/4] asm-generic: io: remove {read,write} string functions
Date: Fri, 26 Oct 2012 13:29:03 +0000
Message-ID: <201210261329.03386.arnd@arndb.de>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com> <1350488704-3711-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758854Ab2JZN3W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Oct 2012 09:29:22 -0400
In-Reply-To: <1350488704-3711-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, Ben Herrenschmidt <benh@kernel.crashing.org>

On Wednesday 17 October 2012, Will Deacon wrote:
> The {read,write}s{b,w,l} functions are not defined across all
> architectures and therefore shouldn't be used by portable drivers. We
> should encourage driver writers to use the io{read,write}{8,16,32}_rep
> functions instead.
> 
> This patch removes the {read,write} string functions for the generic IO
> header as they have no place in a new architecture port.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

What should we do with the series? I can take them through the asm-generic
tree if you like, or we can let Catalin take them through the arm64 tree.

	Arnd
