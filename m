Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:45995 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750945AbWHYRbr
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 13:31:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PHVlDS017570
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 13:31:47 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7PHVkG0274792
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 11:31:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7PHVkJA013318
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 11:31:46 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <10295.1156526193@warthog.cambridge.redhat.com>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <10295.1156526193@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 10:31:38 -0700
Message-Id: <1156527098.12011.199.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-08-25 at 18:16 +0100, David Howells wrote:
> > +     default "14" if PAGE_SIZE_16KB || FRV || CRIS
> > +     default "16" if PAGE_SIZE_64KB || FRV || CRIS
> 
> Whilst the FRV MMU can do 64KB pages (as well as 256KB, 1MB, 2MB, 4MB, 8MB,
> 16MB, ...), have you actually tested the arch port with that setting?

This was a cut and paste error on my part.  I believe I've corrected it
in my latest version (which I'll post shortly).

Here's a snippet:
>         default "13" if PAGE_SIZE_8KB || ALPHA || CRIS || SUN3 || SUN4
>         default "14" if PAGE_SIZE_16KB || FRV
>         default "16" if PAGE_SIZE_64KB || PPC_64K_PAGES
...

-- Dave

