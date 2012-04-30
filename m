From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Move most arches to asm-generic/current.h
Date: Mon, 30 Apr 2012 16:38:29 +0000
Message-ID: <201204301638.29398.arnd@arndb.de>
References: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org> <201204301415.56690.arnd@arndb.de> <4F9EBF3E.8060401@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53449 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192Ab2D3Qif (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 12:38:35 -0400
In-Reply-To: <4F9EBF3E.8060401@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 30 April 2012, Stephen Boyd wrote:
> I admit I haven't compile tested this on all the affected architectures.
> Looking at the architectures that are migrated here I don't see any that
> are defining get_current() as a macro except for alpha. Should I drop
> alpha from the patch? Or would it be easier if someone threw this into
> linux-next and see if it blows up?
> 
> In the meantime I can scrounge around for those kernel.org
> cross-compilers and see if I can compile alpha.

I'd say either get an Ack from the Alpha maintainers or drop that
hunk from your patch.

	Arnd
