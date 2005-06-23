Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42BB3C26.6000603@linux-m68k.org>
Date: Fri, 24 Jun 2005 00:48:06 +0200
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Subject: Re: sparsemem patches in -mm
References: <20050621021352.46fc3b81.akpm@osdl.org>
In-Reply-To: <20050621021352.46fc3b81.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

Hi,

Andrew Morton wrote:

> Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
> please, if you haven't done so...

They would need a bit more work to be usable on m68k. I have a basic
patch to use DISCONTIGMEM for m68k. There I have the problem that I have
to deal with almost random memory configurations. So converting a
virtual/physical address or pfn into a section number can't use a
compile time constant, instead an offset/shift is calculated at boot
time and patched into the kernel.

bye, Roman
