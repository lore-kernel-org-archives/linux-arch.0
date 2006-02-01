Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27164
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932130AbWBALj6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Feb 2006 06:39:58 -0500
Message-Id: <43E0AC2A.76F0.0078.0@novell.com>
Date: Wed, 01 Feb 2006 12:40:10 +0100
From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
References: <20060131143149.35db2e02.akpm@osdl.org>  <200602010836.09932.ak@suse.de> <20060201083243.GB24893@flint.arm.linux.org.uk>
In-Reply-To: <20060201083243.GB24893@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>> Russell King <rmk@arm.linux.org.uk> 01.02.06 09:32:43 >>>
>@ is the comment character on ARM, so this can't go here - we use
>
>	.type name, %function
>
>instead.

Bad.

>Interestingly, the info pages for as seem to indicate that
>there's a number of alternatives - maybe the most benign one should
>be used, iow:
>
>	.type name, "function"

While gas seems to generally accept it, ias doesn't (and the assembly language spec for ia64 doesn't either).

>or alternatively make ENDPROC arch-overridable.

That seems to be the only choice then. I'll send a revised patch soon.

Jan
