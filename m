From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 3/3] docs: atomic_ops: Steer readers towards using refcount_t for reference counts
Date: Sun,  8 Mar 2020 21:00:06 +0100
Message-ID: <20200308200007.23314-1-j.neuschaefer@gmx.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:53429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHUAY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 16:00:24 -0400
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-doc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst         | 6 ++++++
 Documentation/core-api/refcount-vs-atomic.rst | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 73033fc954ad..37a0ffe1a9f1 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -392,6 +392,12 @@ be guaranteed that no other entity can be accessing t=
he object::
 	memory barriers in kfree_skb() that exposed the atomic_t memory barrier
 	requirements quite clearly.

+.. note::
+
+        More recently, reference counts are implement using the
+        :ref:`refcount_t <refcount_t_vs_atomic_t>` type, which works like
+        atomic_t but protects against wraparound.
+
 Given the above scheme, it must be the case that the obj->active
 update done by the obj list deletion be visible to other processors
 before the atomic counter decrement is performed.
diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation=
/core-api/refcount-vs-atomic.rst
index 79a009ce11df..d979ff5166ae 100644
=2D-- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -1,3 +1,5 @@
+.. _refcount_t_vs_atomic_t:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 refcount_t API compared to atomic_t
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-
2.20.1
