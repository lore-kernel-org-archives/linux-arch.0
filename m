From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 02/16] arc: locks: remove unused arch_*_relax
 operations
Date: Mon, 24 Jun 2013 09:58:08 +0100
Message-ID: <20130624085807.GC23779@mudshark.cambridge.arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
 <1371835057-19335-3-git-send-email-will.deacon@arm.com>
 <51C7C729.2080601@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64857 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285Ab3FXI6M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Jun 2013 04:58:12 -0400
Content-Disposition: inline
In-Reply-To: <51C7C729.2080601@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, Jun 24, 2013 at 05:12:25AM +0100, Vineet Gupta wrote:
> Hi Will,
> 
> On 06/21/2013 10:47 PM, Will Deacon wrote:
> > The arch_{spin,read,write}_relax macros are not used anywhere in the
> > kernel and are typically just aliases for cpu_relax().
> >
> > This patch removes the unused definitions for Arc.
> 
> For consistency sake, can you please uppercase to ARC in changelog above. Same
> goes for arc prefix in patch subject.

Sure, I'll update the log. I honestly had no idea about the casing and I was
too lazy to look it up :)

Cheers,

Will
