From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Mon, 09 Jun 2008 21:11:54 +0200
Message-ID: <87abhuqv7p.fsf@basil.nowhere.org>
References: <20080530035620.587204923@sgi.com>
	<20080529215827.b659d032.akpm@linux-foundation.org>
	<4846AFCF.30500@sgi.com> <4848CC22.6090109@cosmosbay.com>
	<Pine.LNX.4.64.0806091136410.30727@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out04.alice-dsl.net ([88.44.63.6]:3997 "EHLO
	smtp-out04.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbYFITMR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jun 2008 15:12:17 -0400
In-Reply-To: <Pine.LNX.4.64.0806091136410.30727@schroedinger.engr.sgi.com> (Christoph Lameter's message of "Mon, 9 Jun 2008 11:44:23 -0700 (PDT)")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

Christoph Lameter <clameter@sgi.com> writes:

> The problem is that offsets relative to %gs or %fs are limited by the 
> small memory model that is chosen.

Actually they are not. If you really want you can do 
movabs $64bit,%reg ; op ...,%gs:(%reg) 
It's just not very efficient compared to small (or rather kernel) model
and also older binutils didn't support large model.

-Andi
