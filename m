From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v2] mm/debug_pagealloc: Ask users for default setting of
 debug_pagealloc
Date: Mon, 25 Jan 2016 16:03:24 +0100
Message-ID: <1453734204.17181.15.camel@tiscali.nl>
References: <1453720528-103788-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:59489 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756257AbcAYPD3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jan 2016 10:03:29 -0500
In-Reply-To: <1453720528-103788-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: peterz@infradead.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org

On ma, 2016-01-25 at 12:15 +0100, Christian Borntraeger wrote:
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug

> +config DEBUG_PAGEALLOC_ENABLE_DEFAULT
> +	bool "Enable debug page memory allocations by default?"
> +        default off

Nit: you apparently meant
	default n

Note that "default off" should also evaluate to "n", which probably
explains why you didn't notice. And "n" is the default anyhow.

So I'm guessing you might as well drop this line.

> +        depends on DEBUG_PAGEALLOC
> +        ---help---
> +	  Enable debug page memory allocations by default? This value
> +	  can be overridden by debug_pagealloc=off|on.
> +
> +	  If unsure say no.

(Really trivial: you start indentation both with spaces and with tabs.
Start with tabs, please.)


Paul Bolle
