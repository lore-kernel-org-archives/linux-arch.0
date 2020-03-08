From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/3] docs: atomic_ops: Move two paragraphs into the warning block above
Date: Sun,  8 Mar 2020 20:56:17 +0100
Message-ID: <20200308195618.22768-3-j.neuschaefer@gmx.net>
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

These two paragraphs seem to be semantically part of the warning text,
so let's adjust the formatting accordingly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/atomic_ops.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-ap=
i/atomic_ops.rst
index 650b9693469a..73033fc954ad 100644
=2D-- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -473,14 +473,14 @@ operation.
         above to return "long" and just returning something like "old_val=
 &
         mask" because that will not work.

-For one thing, this return value gets truncated to int in many code
-paths using these interfaces, so on 64-bit if the bit is set in the
-upper 32-bits then testers will never see that.
-
-One great example of where this problem crops up are the thread_info
-flag operations.  Routines such as test_and_set_ti_thread_flag() chop
-the return value into an int.  There are other places where things
-like this occur as well.
+        For one thing, this return value gets truncated to int in many co=
de
+        paths using these interfaces, so on 64-bit if the bit is set in t=
he
+        upper 32-bits then testers will never see that.
+
+        One great example of where this problem crops up are the thread_i=
nfo
+        flag operations.  Routines such as test_and_set_ti_thread_flag() =
chop
+        the return value into an int.  There are other places where thing=
s
+        like this occur as well.

 These routines, like the atomic_t counter operations returning values,
 must provide explicit memory barrier semantics around their execution.
=2D-
2.20.1
