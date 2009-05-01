From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: RE: [RFC][PATCH 33/35] asm-generic/ptemap.h for HIGHPTE users
Date: Fri, 01 May 2009 11:32:50 -0700
Message-ID: <1241202770.29485.212.camel@nimitz>
References: <20090501144201.D31EF417@kernel>
	 <20090501144252.A2BDDE6B@kernel>
	 <57C9024A16AD2D4C97DC78E552063EA39EF467E5@orsmsx505.amr.corp.intel.com>
	 <1241201452.29485.206.camel@nimitz>
	 <57C9024A16AD2D4C97DC78E552063EA39EF4688A@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:37573 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764810AbZEAScw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 14:32:52 -0400
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA39EF4688A@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2009-05-01 at 11:29 -0700, Luck, Tony wrote:
> >> You need to add a closing #endif here.
> > Fixed, thanks.
> 
> ia64 build fails with:
> 
> arch/ia64/mm/init.c: In function 'put_kernel_page':
> arch/ia64/mm/init.c:248: error: implicit declaration of function 'pte_alloc_kernel'
> arch/ia64/mm/init.c:248: warning: assignment makes pointer from integer without a cast
> make[1]: *** [arch/ia64/mm/init.o] Error 1
> 
> Which I fixed by adding a #include <linux/ptemap.h> to init.c

I need to get a working ia64 compiler.  :)

I'll add that to my 'include linux/ptemap.h at all use sites' patch.

-- Dave
