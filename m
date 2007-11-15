Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759614AbXKOMFi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 07:05:38 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071114213543.GC31048@wotan.suse.de>
References: <20071114213543.GC31048@wotan.suse.de> <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com> <22558.1195055979@redhat.com>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Date: Thu, 15 Nov 2007 12:05:03 +0000
Message-ID: <311.1195128303@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> It can be pretty well any power of 2 from PAGE_SIZE upwards, with
> compound pages. None of the filesystems should really care at all.
> It's not even a new concept, hugetlbfs uses HPAGE_SIZE...

Ummm... The filesystem has to care.  If the VFS/VM says 'fill this page' you
do need to know how big the page is or whether it's even actually several
pages.

David
