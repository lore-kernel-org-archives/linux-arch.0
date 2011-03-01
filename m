From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] asm-generic/user.h: Fix spelling in comment
Date: Tue, 1 Mar 2011 15:50:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103011549400.32580@pobox.suse.cz>
References: <1298885542-6583-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39778 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab1CAOuK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Mar 2011 09:50:10 -0500
In-Reply-To: <1298885542-6583-1-git-send-email-tklauser@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 28 Feb 2011, Tobias Klauser wrote:

> Fix two misspellings.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  include/asm-generic/user.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/user.h b/include/asm-generic/user.h
> index 8b9c3c9..35638c3 100644
> --- a/include/asm-generic/user.h
> +++ b/include/asm-generic/user.h
> @@ -1,8 +1,8 @@
>  #ifndef __ASM_GENERIC_USER_H
>  #define __ASM_GENERIC_USER_H
>  /*
> - * This file may define a 'struct user' structure. However, it it only
> - * used for a.out file, which are not supported on new architectures.
> + * This file may define a 'struct user' structure. However, it is only
> + * used for a.out files, which are not supported on new architectures.
>   */

As this is not in linux-next-20110301, I have picked it up. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
