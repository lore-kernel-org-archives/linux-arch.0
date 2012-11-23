From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Fri, 23 Nov 2012 16:47:27 +0000
Message-ID: <201211231647.27260.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <50AF9C06.3010705@imgtec.com> <50AFA24D.4030501@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54665 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab2KWQr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2012 11:47:29 -0500
In-Reply-To: <50AFA24D.4030501@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Friday 23 November 2012, James Hogan wrote:
> Subject: [PATCH 1/1] asm-generic/io.h: check CONFIG_VIRT_TO_BUS
> 
> Make asm-generic/io.h check CONFIG_VIRT_TO_BUS before defining
> virt_to_bus() and bus_to_virt(), otherwise it's easy to accidentally
> have a silently failing incorrect direct mapped definition rather then
> no definition at all.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Good catch!

Acked-by: Arnd Bergmann <arnd@arndb.de>
