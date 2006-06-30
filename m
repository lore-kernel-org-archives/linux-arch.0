Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:52365 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933014AbWF3S2z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 14:28:55 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Fri, 30 Jun 2006 20:28:38 +0200
References: <1151670404.11575.5.camel@localhost> <20060630104103.0b394b20.akpm@osdl.org>
In-Reply-To: <20060630104103.0b394b20.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606302028.38619.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
List-ID: <linux-arch.vger.kernel.org>


> 
> disable	VT
> 
> and the Kconfig system knows not to offer VT, so there's no need to go
> adding `depends on !DISABLE_foo' all over the place.  The above DISABLE_foo
> convention just simulates that missing feature.

That's a COMEFROM.

Scary idea.

-Andi

