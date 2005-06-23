Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 24 Jun 2005 01:53:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: sparsemem patches in -mm
In-Reply-To: <1119567373.6694.15.camel@localhost>
Message-ID: <Pine.LNX.4.61.0506240139420.3728@scrub.home>
References: <20050621021352.46fc3b81.akpm@osdl.org>  <42BB3C26.6000603@linux-m68k.org>
 <1119567373.6694.15.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Thu, 23 Jun 2005, Dave Hansen wrote:

> As far as the shift, you can simply use the smallest possible size as
> the SECTION_SIZE.

That would waste too much space. 6 bits should be enough. The problem is I 
don't need the top most bits. Patching the shift later into the kernel has 
no real disadvantage at runtime compared to a compile time constant.

bye, Roman
