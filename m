From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 08/14] docs: atomic_ops: Describe atomic_set as a write operation
Date: Mon, 16 Jul 2018 11:05:59 -0700
Message-ID: <20180716180605.16115-8-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

The atomic_set() and ATOMIC_INIT() operations are writes, so this
commit changes their description from "reads" to "writes".

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 Documentation/core-api/atomic_ops.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 2e7165f86f55..724583453e1f 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -29,7 +29,7 @@ updated by one CPU, local_t is probably more appropriate. Please see
 local_t.
 
 The first operations to implement for atomic_t's are the initializers and
-plain reads. ::
+plain writes. ::
 
 	#define ATOMIC_INIT(i)		{ (i) }
 	#define atomic_set(v, i)	((v)->counter = (i))
-- 
2.17.1
