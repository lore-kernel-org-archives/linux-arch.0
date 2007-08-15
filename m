Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3836 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765019AbXHOOzn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2007 10:55:43 -0400
Message-ID: <46C313B3.4020409@shadowen.org>
Date: Wed, 15 Aug 2007 15:54:43 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] vmemmap: generify initialisation via helpers
References: <exportbomb.1186756801@pinky> <E1IJVf4-0004oZ-6G@localhost.localdomain> <Pine.LNX.4.64.0708101055360.13640@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0708101055360.13640@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter wrote:
> That exports a series of new function. The function are always compiled in 
> even if not needed right?
> 
> Acked-by: Christoph Lameter <clameter@sgi.com>

Yes.  We are assuming the compiler is going to help us out.  They are
mostly trivial and all __meminit.

-apw
