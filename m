From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V3 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Date: Tue, 28 Oct 2014 12:20:29 +1100
Message-ID: <1414459229.31711.0.camel@concordia>
References: <1414233860-7683-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
	 <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:60944 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbaJ1BUb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Oct 2014 21:20:31 -0400
In-Reply-To: <20141027160612.b7fd0b1cc9d82faeaa674940@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Andrea Arcangeli <aarcange@redhat.com>, benh@kernel.crashing.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org

On Mon, 2014-10-27 at 16:06 -0700, Andrew Morton wrote:
> On Sat, 25 Oct 2014 16:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > Update generic gup implementation with powerpc specific details.
> > On powerpc at pmd level we can have hugepte, normal pmd pointer
> > or a pointer to the hugepage directory.
> 
> I grabbed these.  It would be better if they were merged into the powerpc
> tree where they'll get more testing than in linux-next alone.
 
Fine by me. Can I get an ack from you and/or someone else on CC?

cheers
