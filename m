Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from auth-3.ukservers.net ([217.10.138.152]:48548 "EHLO
	auth-3.ukservers.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbCTRmq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2015 13:42:46 -0400
Message-ID: <550C5993.9030104@youngman.org.uk>
Date: Fri, 20 Mar 2015 17:32:03 +0000
From: Wols Lists <antlists@youngman.org.uk>
MIME-Version: 1.0
Subject: Re: [Linux-nvdimm] [RFC PATCH 0/7] evacuate struct page from the
 block layer
References: <20150316201640.33102.33761.stgit@dwillia2-desk3.amr.corp.intel.com>	<20150318132650.3336261c58829f49a9af8675@linux-foundation.org>	<20150319134313.GF4003@linux.intel.com>	<550AF127.9010504@plexistor.com> <20150319125917.6cc2bf02687aab542027d8ac@linux-foundation.org>
In-Reply-To: <20150319125917.6cc2bf02687aab542027d8ac@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Boaz Harrosh <boaz@plexistor.com>
Cc: Matthew Wilcox <willy@linux.intel.com>, linux-arch@vger.kernel.org, axboe@kernel.dk, riel@redhat.com, hch@infradead.org, linux-nvdimm@ml01.01.org, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mgorman@suse.de, linux-fsdevel@vger.kernel.org
Message-ID: <20150320173203.8-Wvto6mbbxpdIJXMWK9Ds3TtRGZn497aE0pEo_YGf8@z>

On 19/03/15 19:59, Andrew Morton wrote:
> This is all contingent upon the prevalence of machines which have vast
> amounts of nv memory and relatively small amounts of regular memory. 
> How confident are we that this really is the future?

Somewhat off-topic, but it's also the past. I can't help thinking of the
early Pick machines, which treated backing store as one giant permanent
virtual memory. Back when 300Mb hard drives were HUGE.

Cheers,
Wol


