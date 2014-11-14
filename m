Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59469 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965580AbaKNSxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Nov 2014 13:53:30 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v6 0/7] vfs: Non-blockling buffered fs read (page cache only)
References: <cover.1415636409.git.milosz@adfin.com>
	<20141111064417.GT23575@dastard>
	<x49mw7tyc7e.fsf@segfault.boston.devel.redhat.com>
	<20141114163912.GA23769@redhat.com>
	<CANP1eJH6BNiJ8zwA2Ba4Dc-2NZ5s2TBE4NVg3Ydk_cvSdDQUFQ@mail.gmail.com>
Date: Fri, 14 Nov 2014 13:52:42 -0500
In-Reply-To: <CANP1eJH6BNiJ8zwA2Ba4Dc-2NZ5s2TBE4NVg3Ydk_cvSdDQUFQ@mail.gmail.com>
	(Milosz Tanski's message of "Fri, 14 Nov 2014 13:45:02 -0500")
Message-ID: <x49r3x5vclh.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Dave Jones <davej@redhat.com>, Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20141114185242.QtJjxg9ugUWUHS6AlC-pKfQdEaP76zw4Yo6cG_sRlyA@z>

Milosz Tanski <milosz@adfin.com> writes:

> On a unrelated note I just back to figuring out how to add this to
> xfstests. I got busy with other things the last few days. I'm still
> not quite sure how to write a test using the framework, the
> documentation (README) seams very XFS specific and otherwise the test
> seam to be be split between many different files / directories / C
> code / shell code. I might be me being slow... but it's just not
> obvious for me how to glue the whole thing together.

I can help you get started with this.  I'll send email off-list.

Cheers,
Jeff
