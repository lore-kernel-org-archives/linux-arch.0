Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:42465 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607AbcFAQwY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jun 2016 12:52:24 -0400
Subject: Re: [PATCH 7/8] pkeys: add details of system call use to
 Documentation/
References: <20160531152814.36E0B9EE@viggo.jf.intel.com>
 <20160531152824.2B18E890@viggo.jf.intel.com>
 <20160601104333.7c2014fa@lwn.net>
From: Dave Hansen <dave@sr71.net>
Message-ID: <574F114F.8010701@sr71.net>
Date: Wed, 1 Jun 2016 09:46:07 -0700
MIME-Version: 1.0
In-Reply-To: <20160601104333.7c2014fa@lwn.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160601164607.Xh7DLKKzh224rIgxmPBBNSG-yZZ3g9KFMIglDdQ1MjI@z>

On 06/01/2016 09:43 AM, Jonathan Corbet wrote:
>> > +There are 5 system calls which directly interact with pkeys:
>> > +
>> > +	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
>> > +	int pkey_free(int pkey);
>> > +	int sys_pkey_mprotect(unsigned long start, size_t len,
>> > +			      unsigned long prot, int pkey);
>> > +	unsigned long pkey_get(int pkey);
>> > +	int pkey_set(int pkey, unsigned long access_rights);
> sys_pkey_mprotect() should just be pkey_mprotect(), right?

Yes, and that are a few more instances of that farther down in the file.
 I'll fix them all up.
