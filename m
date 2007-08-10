Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:38077 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755831AbXHJR4Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2007 13:56:25 -0400
Date: Fri, 10 Aug 2007 10:56:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1/5] vmemmap: generify initialisation via helpers
In-Reply-To: <E1IJVf4-0004oZ-6G@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0708101055360.13640@schroedinger.engr.sgi.com>
References: <exportbomb.1186756801@pinky> <E1IJVf4-0004oZ-6G@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

That exports a series of new function. The function are always compiled in 
even if not needed right?

Acked-by: Christoph Lameter <clameter@sgi.com>


