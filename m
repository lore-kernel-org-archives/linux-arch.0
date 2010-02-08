From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the
 PIOmapping API
Date: Mon, 08 Feb 2010 13:09:31 -0600
Message-ID: <1265656171.6289.26.camel@mulgrave.site>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <20100208165417.GA29551@flint.arm.linux.org.uk>
	 <1265652171.4020.165.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35242 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754062Ab0BHTJd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 14:09:33 -0500
In-Reply-To: <1265652171.4020.165.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org

On Mon, 2010-02-08 at 18:02 +0000, Catalin Marinas wrote:
> If we do cache flushing in kunmap() we wouldn't need an additional cache
> flushing for highmem pages, so you can implement pio_kunmap()
> accordingly. James' point in a previous e-mail was that he doesn't want
> drivers to have "if (!PageHighMem(page))".
> 
> Now, the ARM kunmap() function doesn't seem to do any flushing, only
> kunmap_atomic(). Do I miss anything?
> 
> Also, for PIPT caches we don't actually create any D-cache aliases with
> kmap, so I'm not sure why we need to always flush the cache in kunmap().

Right ... this is why the implementation is arch specific.  The PIPT
implementation would be a nop for lowmem and directly equivalent to the
corresponding kmap for highmem (no flushes ... unless there are platform
semantics requiring them because of the mappings that are in the kmaps
anyway).

James
