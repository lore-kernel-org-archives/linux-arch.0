From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and
 family
Date: Sat, 22 Feb 2014 13:54:49 -0800
Message-ID: <53091CA9.3060403@infradead.org>
References: <20140222192325.GA12587@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36966 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaBVVzA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Feb 2014 16:55:00 -0500
In-Reply-To: <20140222192325.GA12587@thin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/22/2014 11:23 AM, Josh Triplett wrote:

Hi Josh,

If you redo these patches, please make while(0) not look like a
function call, i.e., use while (0) instead.

> +#else /* !CONFIG_BUG */
> +#ifndef HAVE_ARCH_BUG
> +#define BUG() do {} while(0)
> +#endif
> +
> +#ifndef HAVE_ARCH_BUG_ON
> +#define BUG_ON(condition) do { if (condition) ; } while(0)
> +#endif

Thanks.
-- 
~Randy
