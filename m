Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992834AbXDDKbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Apr 2007 06:31:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070404040232.2FEF6DDEBA@ozlabs.org> 
References: <20070404040232.2FEF6DDEBA@ozlabs.org> 
Subject: Re: [PATCH 12/14] get_unmapped_area handles MAP_FIXED in /dev/mem (nommu) 
Date: Wed, 04 Apr 2007 11:31:09 +0100
Message-ID: <23349.1175682669@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> +	if (flags & MAP_FIXED)
> +		if ((addr >> PAGE_SHIFT) != pgoff)
> +			return (unsigned long) -EINVAL;

Again... in NOMMU-mode there is no MAP_FIXED - it's rejected before we get
this far.

> -	return pgoff;
> +	return pgoff << PAGE_SHIFT;

That, however, does appear to be a genuine bugfix.

David
