Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfDJJ4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 05:56:38 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 0/8] Prepare files under Documentation/*.txt to build with Sphinx
Date: Wed, 10 Apr 2019 06:56:19 -0300
Message-ID: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
Message-ID: <20190410095619.1mxGTmiR8dP_u5UcdzJXtJ0hVYFo6TZhfEXO6_yeGHA@z>

In the past, we did some efforts to ensure that almost all files under
Documentation/*.txt could be built with Sphinx.

Some regressions happened there (and some new files got added).
Fix those files in order to allow them to be able to build with Sphinx.

The changes on this series are trivial, adding the minimum stuff to allow
building those files with sphinx-build with no warnings and to make the
contents minimally consistent with other documentation files.

Mauro Carvalho Chehab (8):
  docs: DMA-API-HOWTO: add a missing "="
  docs: atomic_bitops.txt: add a title for this document
  docs: clearing-warn-once.txt: add a title for this document
  docs: ntb.txt: use Sphinx notation for the two ascii figures
  docs: unaligned-memory-access.txt: use a lowercase title
  docs: video-output.txt: convert it to ReST format
  docs: ntb.txt: add blank lines to clean up some Sphinx warnings
  docs: speculation.txt: mark example blocks as such

 Documentation/DMA-API-HOWTO.txt           |  2 +-
 Documentation/atomic_bitops.txt           |  6 +--
 Documentation/clearing-warn-once.txt      |  2 +
 Documentation/ntb.txt                     | 14 ++++--
 Documentation/speculation.txt             |  8 ++--
 Documentation/unaligned-memory-access.txt |  2 +-
 Documentation/video-output.txt            | 52 +++++++++++------------
 7 files changed, 47 insertions(+), 39 deletions(-)

-- 
2.20.1
