Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXKNN5A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 08:57:00 -0500
From: David Howells <dhowells@redhat.com>
Subject: Should PAGE_CACHE_SIZE be discarded?
Date: Wed, 14 Nov 2007 13:56:53 +0000
Message-ID: <17161.1195048613@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com, npiggin@suse.de
List-ID: <linux-arch.vger.kernel.org>


Are we ever going to have PAGE_CACHE_SIZE != PAGE_SIZE?  If not, why not
discard PAGE_CACHE_SIZE as it's then redundant.

PAGE_CACHE_SIZE is also an ill-defined concept.  Just grep in Documentation/
and it only comes up in a couple of places, neither particularly informative.

If there's a possibility that it will be used, then someone who knows how it's
supposed to work needs to sit down and document what it is, what it represents,
where it applies, how it interacts with PG_compound and how the page flags
distribute over a page cache slot.

One further thing to consider: actually making PAGE_CACHE_SIZE > PAGE_SIZE
work will be an interesting problem, as I'm certain most filesystems will
break horribly without a lot of work (ramfs might be only exception).

David
