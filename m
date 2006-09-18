Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:49610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751866AbWIRRyH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 13:54:07 -0400
Date: Mon, 18 Sep 2006 10:53:50 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/3] Directed yield.
Message-Id: <20060918105350.25f02252.akpm@osdl.org>
In-Reply-To: <20060918121959.GA3290@skybase>
References: <20060918121959.GA3290@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 18 Sep 2006 14:19:59 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> nobody has complained about my spinlock yield patches.

Complain.

I had to hunt around a bit to discover that this functionality has
something to do with "giving up the timeslice of a virtual cpu in favour of
a specific cpu".  And also that it is expected to be of some
briefly-alluded-to benefit on powerpc.

So...  Could you please flesh out the description/rationale rather a lot
and cc linux-kernel on the patches?

Thanks.
