From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC v2][PATCH 00/35] consolidate pte mapping functions across
 all architectures
Date: Wed, 20 May 2009 15:38:22 -0700
Message-ID: <1242859102.11900.2.camel@nimitz>
References: <20090520182445.D7B49A7C@kernel>  <4A147EEC.4000807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:55586 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZETWiW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2009 18:38:22 -0400
In-Reply-To: <4A147EEC.4000807@goop.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2009-05-20 at 15:06 -0700, Jeremy Fitzhardinge wrote: 
> Dave Hansen wrote:
> > The steps are as follows, and should be bisectable:
> > 1. Break out all the functions into a new asm/ptemap.h and
> >    include it in place of the original functions.
> > 2. Move linux/mm.h arch-independent pte mapping code to
> >    linux/ptemap.h, include asm/ptemap.h there
> > 3. Include linux/ptemap.h directly at all use sites
> >    (only 39 of these kernel-wide)
> > 4. Standardize all the implementations to use
> >    pte_offset_kernel() as the basis for pte_offset_map()
> >    whenever possible.
> > 5. Create asm-generic/ptemap.h and consolidate all the
> >    architectures that share the pte_offset_kernel()
> >    implementations.
> > 6. Consolidate the three HIGHPTE implementations (x86,
> >    frv, ppc64) in asm-generic/ptemap.h.  
> > 7. Remove the direct asm/ptemap.h includes.   
> 
> This is a nice cleanup.  Did you consider going an extra step and 
> converting all the macros into #defines?

Yup.  I actually have a patch doing this sitting around that just needs
a bit of cleanup.  I'll certainly submit it if these get in.

-- Dave
