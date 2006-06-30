Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:54492 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932593AbWF3Mo5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 08:44:57 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Fri, 30 Jun 2006 14:44:26 +0200
References: <1151670404.11575.5.camel@localhost>
In-Reply-To: <1151670404.11575.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301444.26446.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 30 June 2006 14:26, Martin Schwidefsky wrote:
> Hi folks,
> it has been a few weeks since the s390 kconfig discussion died down.
> I have put together a new patch that includes all of the suggestions
> made so far. With this patch "make allyesconfig" and "make allmodconfig"
> now works on s390.
> 
> Please check that it does not break anything on your favorite 
> architecture. It really shouldn't but you never know. I want to push
> this patch soon.

I must say I still hate the negative !S390. It would be much better
to define something positive. If PCI doesn't work maybe something 
else.

-Andi
