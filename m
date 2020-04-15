Return-Path: <SRS0=yBTr=57=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:59556 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728269AbgDOVtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 17:49:10 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id C9F4418036414
        for <linux-arch@vger.kernel.org>; Wed, 15 Apr 2020 21:42:17 +0000 (UTC)
Message-ID: <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
From: Joe Perches <joe@perches.com>
Date: Wed, 15 Apr 2020 14:39:59 -0700
In-Reply-To: <20200415184945.16487-6-paulmck@kernel.org>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
         <20200415184945.16487-6-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>
Message-ID: <20200415213959.cY9HRQj1-Oth0ce0-S8ZudLzUurGZ7HTfjLkYL2fK7c@z>

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
