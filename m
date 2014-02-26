Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:51745 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaBZN3N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2014 08:29:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/5] bug: Make BUG() call unreachable()
Date: Wed, 26 Feb 2014 14:29:06 +0100
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org> <d97712e037ea4c90e9cb30c56229383d257831de.1393385236.git.josh@joshtriplett.org>
In-Reply-To: <d97712e037ea4c90e9cb30c56229383d257831de.1393385236.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201402261429.06553.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20140226132906.gcGVrJ7zE6PiA9cNFMnilMM0kyjxvphH2T8cCqffUuM@z>

On Wednesday 26 February 2014, Josh Triplett wrote:
> @@ -134,7 +134,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>  
>  #else /* !CONFIG_BUG */
>  #ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while (0)
> +#define BUG() do { unreachable(); } while (0)
>  #endif

I disagree with this one. As Alan said, we really want to use an
arch specific BUG() even in the !CONFIG_BUG case.

For the cases where this is not yet possible, I'd suggest using

#define BUG() do { } while (1)


For older gcc versions, this is actually the same as unreachable(), but
it is not the same as __builtin_unreachable, because it causes undefined
behavior.

	Arnd
