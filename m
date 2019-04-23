Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWRNA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 13:13:00 -0400
Date: Tue, 23 Apr 2019 19:12:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423171256.GH12232@hirez.programming.kicks-ass.net>
References: <20190423132100.GB7132@redhat.com>
 <cover.1555938375.git.mchehab+samsung@kernel.org>
 <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
 <20190423083135.GA11158@hirez.programming.kicks-ass.net>
 <20190423125519.GA7104@redhat.com>
 <20190423130132.GT4038@hirez.programming.kicks-ass.net>
 <20704.1556031146@warthog.procyon.org.uk>
 <20190423105415.3a69a0cb@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423105415.3a69a0cb@lwn.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Howells <dhowells@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190423171256.pqBVuDUNogwvL1KrHEpZptxFin4EXoHrsJOt6D_V1kQ@z>

On Tue, Apr 23, 2019 at 10:54:15AM -0600, Jonathan Corbet wrote:
> Few people complain about the biggest impediment to the readability of
> text files, though: the use of kerneldoc comments.

I just stopped using kerneldoc.
