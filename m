From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] Use microsecond granularity for taskstats accounting
Date: Fri, 14 May 2010 14:28:48 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D53C6120ABB@orsmsx505.amr.corp.intel.com>
References: <1273843352.2615.61.camel@holzheu-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10403 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab0ENV3F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 17:29:05 -0400
In-Reply-To: <1273843352.2615.61.camel@holzheu-laptop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "martin.schwidefsky@de.ibm.com" <martin.schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "jlan@sgi.com" <jlan@sgi.com>, "balbir@linux.vnet.ibm.com" <balbir@linux.vnet.ibm.com>

You delete the only users of cputime_to_msecs() ... should
you also delete the definition from asm-generic/cputime.h?
Same for the msecs_to_cputime() that had no users.

Is it worth adding the usecs_to_cputime() functions/macros.
Symmetry is nice (and matches what used to be there, but
unused code isn't very worthwhile.

-Tony
