Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422711AbWHYRQh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 13:16:37 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain> 
References: <20060824234445.6B519D52@localhost.localdomain> 
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions 
Date: Fri, 25 Aug 2006 18:16:33 +0100
Message-ID: <10295.1156526193@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Dave Hansen <haveblue@us.ibm.com> wrote:

> +	default "14" if PAGE_SIZE_16KB || FRV || CRIS
> +	default "16" if PAGE_SIZE_64KB || FRV || CRIS

Whilst the FRV MMU can do 64KB pages (as well as 256KB, 1MB, 2MB, 4MB, 8MB,
16MB, ...), have you actually tested the arch port with that setting?

David
