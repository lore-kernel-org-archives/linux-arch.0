Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5NMuQtE019842
	for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2005 18:56:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5NMuQKb223598
	for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2005 18:56:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5NMuQFS029415
	for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2005 18:56:26 -0400
Subject: Re: sparsemem patches in -mm
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <42BB3C26.6000603@linux-m68k.org>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	 <42BB3C26.6000603@linux-m68k.org>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 15:56:13 -0700
Message-Id: <1119567373.6694.15.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2005-06-24 at 00:48 +0200, Roman Zippel wrote:
> Andrew Morton wrote:
> > Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> > please, if you haven't done so...
> 
> They would need a bit more work to be usable on m68k. I have a basic
> patch to use DISCONTIGMEM for m68k. There I have the problem that I have
> to deal with almost random memory configurations. So converting a
> virtual/physical address or pfn into a section number can't use a
> compile time constant, instead an offset/shift is calculated at boot
> time and patched into the kernel.

As far as the shift, you can simply use the smallest possible size as
the SECTION_SIZE.

Nothing I can think of with sparsemem requires you to have the kernel be
at pfn 0.  Unless you start at some completely huge address or have an
exceedingly low SECTION_SIZE, everything should fit.  Remember,
sparsemem doesn't deal with virt/phys layout, just converting pfns to
and from pages.  

If you want to mail me, or take this to your arch's list, we can
probably discuss more of the specifics for your arch.

-- Dave
