From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Wed, 10 Jun 2009 18:08:39 -0500
Message-ID: <56E05C63-D29C-405E-B9B1-29F300BBA43B@kernel.crashing.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49933 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870AbZFJXJV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Jun 2009 19:09:21 -0400
In-Reply-To: <20090602172941.GL3095@hansolo.jdub.homelinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org


On Jun 2, 2009, at 12:29 PM, Josh Boyer wrote:

> Which leads me to suggest that it is at least worth having someone  
> with an
> embedded focus at KS to simply keep an eye out for impacts of  
> generic changes.
> "Feature parity" is something I often deal with in trying to keep  
> ppc4xx up to
> speed with the rest of the archs in the kernel.

I think this is an interesting topic by itself.  How to keep embedded  
(or non-x86) arch's up with features being developed that are core  
kernel.  For example, I know Roland would use 4xx to test his  
infiniband since it was non-coherent system.

- k
