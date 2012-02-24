From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] [PATCH] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Fri, 24 Feb 2012 16:38:11 +0000
Message-ID: <201202241638.12205.arnd@arndb.de>
References: <4F47981F.4020305@imgtec.com> <201202241119.44480.vapier@gentoo.org> <201202241637.30284.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53649 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab2BXQiR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 11:38:17 -0500
In-Reply-To: <201202241637.30284.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Friday 24 February 2012, Arnd Bergmann wrote:
> We actually have MODULE_SYMBOL_PREFIX providing the correct string
> under a name that is not appropriate here. We can probably stick with
> Jason's patch for now and add a more sophisticated logic if another
> user of CONFIG_SYMBOL_PREFIX comes up.
> 
> So for Jason's patch:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> We could put that into the kernel now, but it's probably sufficient if
> Jason keeps the patch with his others and submits it at the same time
> when we get there.

Sorry, I meant s/Jason/James/g
