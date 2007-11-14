Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbXKNP7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 10:59:44 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071114152345.GB20973@wotan.suse.de>
References: <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Date: Wed, 14 Nov 2007 15:59:39 +0000
Message-ID: <22558.1195055979@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> Christoph Lameter has patches exactly to make PAGE_CACHE_SIZE larger than
> PAGE_SIZE, and they seem to work without much effort. I happen to hate the
> patches ;) but that doesn't change the fact that PAGE_CACHE_SIZE is
> relatively useful and it is not at all an ill-defined concept.

Where, please? mm kernels?

> Basically, anything that goes in the page cache is in units of
> PAGE_CACHE_SIZE, and nothing else. For filesystems it should be pretty
> easy...

That depends on what the coverage of struct page is.  I don't actually know
whether this is PAGE_SIZE or PAGE_CACHE_SIZE; I assumed it to be the former,
but from what you've said, I'm not actually sure.

David
