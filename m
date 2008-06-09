From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv4 1/6] byteorder: add a new include/linux/swab.h to
 define byteswapping functions
Date: Mon, 9 Jun 2008 15:10:08 -0700
Message-ID: <20080609151008.c5b7d276.akpm@linux-foundation.org>
References: <1212428241.11008.35.camel@brick>
	<1213040628.5974.76.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46600 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754125AbYFIWK2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jun 2008 18:10:28 -0400
In-Reply-To: <1213040628.5974.76.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com

On Mon, 09 Jun 2008 12:43:48 -0700
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> On Mon, 2008-06-02 at 10:37 -0700, Harvey Harrison wrote:
> > Collect the implementations from include/linux/byteorder/swab.h, swabb.h
> > in swab.h
> > 
> 
> Andrew, any chance of getting 1-5 of 6 into -mm?
> 
> Do you want a resend?
> 

Spose so.

Sorry, but I rather suffered brain burstage trying to follow all these
byte-twiddling patches and went off and looked at other things.  The
frequency of whoops-that-didn't-work-try-this-one didn't help..
