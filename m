Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:10676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932865AbWF3Rl0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 13:41:26 -0400
Date: Fri, 30 Jun 2006 10:41:03 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Message-Id: <20060630104103.0b394b20.akpm@osdl.org>
In-Reply-To: <1151670404.11575.5.camel@localhost>
References: <1151670404.11575.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
List-ID: <linux-arch.vger.kernel.org>

On Fri, 30 Jun 2006 14:26:44 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

>  config VT
>  	bool "Virtual terminal" if EMBEDDED
> +	depends on !S390

It would be more general to do

	depends on !DISABLE_VT

then define DISABLE_VT over in arch/s390/Kconfig.

In fact we could adopt that as a convention and use the CONFIG_DISABLE_foo
namespace for this purpose.



Even better would be to teach the Kconfig sytem about this, so in
arch/s390/Kconfig we do

disable	VT

and the Kconfig system knows not to offer VT, so there's no need to go
adding `depends on !DISABLE_foo' all over the place.  The above DISABLE_foo
convention just simulates that missing feature.


> +	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390

Imagine not having crud like this in there.
