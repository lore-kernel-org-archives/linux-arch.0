From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
Date: Wed, 15 Apr 2020 14:39:59 -0700
Message-ID: <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
         <20200415184945.16487-6-paulmck@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415184945.16487-6-paulmck@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> Also add me as Reviewer for LKMM. Previously a patch to do this was
> Acked but somewhere along the line got lost. Add myself in this patch.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
> +R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  S:	Supported
> @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
>  F:	tools/memory-model/
> +F:	Documentation/litmus-tests/

trivia:

Alphabetic ordering of F: entries please.
This should be between core-api and memory-barriers.

>  LIS3LV02D ACCELEROMETER DRIVER
>  M:	Eric Piel <eric.piel@tremplin-utc.net>
