Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:36710 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbcFAQtj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jun 2016 12:49:39 -0400
Date: Wed, 1 Jun 2016 10:49:37 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 7/8] pkeys: add details of system call use to
 Documentation/
Message-ID: <20160601104937.098a89a2@lwn.net>
In-Reply-To: <574F114F.8010701@sr71.net>
References: <20160531152814.36E0B9EE@viggo.jf.intel.com>
	<20160531152824.2B18E890@viggo.jf.intel.com>
	<20160601104333.7c2014fa@lwn.net>
	<574F114F.8010701@sr71.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160601164937.7rJyx2UThnfFXxb92VjNu03xFc2unYk688e3o3OFVNE@z>

On Wed, 1 Jun 2016 09:46:07 -0700
Dave Hansen <dave@sr71.net> wrote:

> On 06/01/2016 09:43 AM, Jonathan Corbet wrote:
> >> > +There are 5 system calls which directly interact with pkeys:
> >> > +
> >> > +	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
> >> > +	int pkey_free(int pkey);
> >> > +	int sys_pkey_mprotect(unsigned long start, size_t len,
> >> > +			      unsigned long prot, int pkey);
> >> > +	unsigned long pkey_get(int pkey);
> >> > +	int pkey_set(int pkey, unsigned long access_rights);  
> > sys_pkey_mprotect() should just be pkey_mprotect(), right?  
> 
> Yes, and that are a few more instances of that farther down in the file.
>  I'll fix them all up.

While you're at it (I shouldn't have hit send quite so quickly :) 

> +	sys_pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
> +	sys_pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE);
> +	something(ptr);

That should, IMO, be something like:

	key = pkey_alloc(...);
	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, key);

?


jon
