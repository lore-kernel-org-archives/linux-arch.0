From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/3] docs: atomic_ops: Remove colons where they don't make sense
Date: Sun,  8 Mar 2020 20:56:16 +0100
Message-ID: <20200308195618.22768-2-j.neuschaefer@gmx.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Sender: linux-doc-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
List-Id: linux-arch.vger.kernel.org

There are a few cases on atomic_ops.rst, where a end-of-line colon
before a code block seems semantically wrong, because the code block is
not related to the sentence before it.

End those lines with `. ::` instead, which is rendered as a period but
still formats the next line/block as a code block.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 724583453e1f..650b9693469a 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -242,13 +242,13 @@ given atomic counter.  They return a boolean indicat=
ing whether the
 resulting counter value was zero or not.

 Again, these primitives provide explicit memory barrier semantics around
-the atomic operation::
+the atomic operation. ::

 	int atomic_sub_and_test(int i, atomic_t *v);

 This is identical to atomic_dec_and_test() except that an explicit
 decrement is given instead of the implicit "1".  This primitive must
-provide explicit memory barrier semantics around the operation::
+provide explicit memory barrier semantics around the operation. ::

 	int atomic_add_negative(int i, atomic_t *v);

=2D-
2.20.1
