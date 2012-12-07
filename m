From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using IO functions across ARM, PPC and Microblaze architectures
Date: Fri, 7 Dec 2012 21:16:06 +0000
Message-ID: <20121207211606.6c5d5bc8@pyramind.ukuu.org.uk>
References: <CAHTX3d+VNDVQjnTnAB=Ywxo7odvNmCPu=wGZ03-xWLecSMsS9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56971 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424546Ab2LGVKk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2012 16:10:40 -0500
In-Reply-To: <CAHTX3d+VNDVQjnTnAB=Ywxo7odvNmCPu=wGZ03-xWLecSMsS9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> Because I need to use IO functions which will behave
> on arm as little endian and on powerpc as big endian
> and on microblaze depends on endian setting.
> I haven't found any IO function which I could use by 3 architectures
> without using preprocessor macros or runtime detection

Its a rather weird mix. We can do "always big" and "always little"

> 1. Using helper function + preprocessor macros
> (using static inline function also possible)

Then someone comes along and sticks a daughterboard into the system with
the same device the other way around and there are years

> 2. Using function pointers

Probably smarter. 8250.c works this way and it has to handle some
extremely bizarre mappings.
 
> b) Runtime initialization - here is the question if there is
> any standard function which I could use.

Set the pointers up and pass them as data with your platform device, that
way the function definitions are buried in your platform code where they
depend.

Alan
