From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] asm-generic/mutex-dec.h: add SMP support
Date: Mon, 30 May 2011 09:00:02 +0200
Message-ID: <201105300900.02884.arnd@arndb.de>
References: <1306725568-10922-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63012 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1E3HAR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2011 03:00:17 -0400
In-Reply-To: <1306725568-10922-1-git-send-email-vapier@gentoo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Monday 30 May 2011 05:19:28 Mike Frysinger wrote:
> To make these guys work on SMP systems, we just need to sprinkle a few
> barriers around.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> note: this is what the Blackfin SMP port is using, but it doesn't seem
> like other SMP ports are ... so I wonder if we're just trying too hard
> and these barriers aren't actually necessary ?

On some architectures, atomic instructions are implicit barriers. On
others, the cmpxchg() macro contains a barrier. I'm not sure if there
is other code relying on that.

	Arnd
