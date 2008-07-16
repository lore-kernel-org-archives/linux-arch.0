From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/20] generic show_mem() v5
Date: Wed, 16 Jul 2008 15:06:32 -0700
Message-ID: <20080716150632.9b7f3555.akpm@linux-foundation.org>
References: <20080704160737.750988999@saeurebad.de>
	<1216148794.25942.11.camel@nimitz>
	<20080715132203.a9482685.akpm@linux-foundation.org>
	<1216245100.8711.8.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755353AbYGPWHH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jul 2008 18:07:07 -0400
In-Reply-To: <1216245100.8711.8.camel@nimitz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: hannes@saeurebad.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de, stable@kernel.org

On Wed, 16 Jul 2008 14:51:40 -0700
Dave Hansen <dave@linux.vnet.ibm.com> wrote:

> On Tue, 2008-07-15 at 13:22 -0700, Andrew Morton wrote:
> > 
> > > The sections are 512MB, and you can see 6 valid ones
> > > followed by two holes, and then two more valid ones.
> > > 
> > > Anyway, I believe this patch will fix the oops.
> > 
> > This looks like it might be suitable.  Can you please test it?
> 
> I compiled, tested, and booted on the machine that had this problem.  It
> hasn't reappeared.
> 

Confused.   Did you have your patch applied or not?

I assume you did, in which case can you please send over a final
changelogged, titled and signed-off patch?
