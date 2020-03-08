From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Date: Sun,  8 Mar 2020 20:56:15 +0100
Message-ID: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:42973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCHT5C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 15:57:02 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-doc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Hi,

this is a short series of unrelated fixes that make the atomic
operations documentation look and read a bit better.

Jonathan Neusch=C3=A4fer (3):
  docs: atomic_ops: Remove colons where they don't make sense
  docs: atomic_ops: Move two paragraphs into the warning block above
  docs: atomic_ops: Steer readers towards using refcount_t for reference
    counts

 Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------
 Documentation/core-api/refcount-vs-atomic.rst |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

=2D-
2.20.1
