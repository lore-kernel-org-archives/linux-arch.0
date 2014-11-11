Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbaKKREJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Nov 2014 12:04:09 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v6 0/7] vfs: Non-blockling buffered fs read (page cache only)
References: <cover.1415636409.git.milosz@adfin.com>
	<20141111064417.GT23575@dastard>
	<CANP1eJHfWT0Foe+weB1SJkJ10JnOge_g=E8CXBsQNPW7i2+4NA@mail.gmail.com>
Date: Tue, 11 Nov 2014 12:03:14 -0500
In-Reply-To: <CANP1eJHfWT0Foe+weB1SJkJ10JnOge_g=E8CXBsQNPW7i2+4NA@mail.gmail.com>
	(Milosz Tanski's message of "Tue, 11 Nov 2014 11:02:00 -0500")
Message-ID: <x49ioilbrfx.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20141111170314.CVM__3ET68zX3aLfV_klhKYCeChLnvH_qSow54JsaEY@z>

Milosz Tanski <milosz@adfin.com> writes:

>> Can you write a test (or set of) for fstests that exercises this new
>> functionality? I'm not worried about performance, just
>> correctness....
>
> Sure thing. Can you point me at the fstests repo? A quick google
> search reveals lots of projects named fstests, most of them abandoned.

I think he's referring to xfstests.  Still, I think that's the wrong
place for functional testing.  ltp would be better, imo.

Cheers,
Jeff
