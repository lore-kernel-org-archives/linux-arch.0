From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: current_thread_info() vs task_thread_info(current)
Date: Mon, 18 Jul 2011 13:44:50 +0200
Message-ID: <1310989490.13765.57.camel@twins>
References: <1310988183.13765.56.camel@twins>
	 <20110718113600.GI2400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51253 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1GRLpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2011 07:45:13 -0400
In-Reply-To: <20110718113600.GI2400@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@us.ibm.com>

On Mon, 2011-07-18 at 14:36 +0300, Gleb Natapov wrote:

> Why not use per cpu kernel_stack variable on all arches as x86_64 does?
> How big the advantage of using stack pointer to find current thread info is?

One less load I imagine.
