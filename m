Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51377 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbZFVIK6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2009 04:10:58 -0400
Date: Mon, 22 Jun 2009 10:10:45 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: handle_mm_fault() calling convention cleanup..
Message-ID: <20090622081045.GB11041@elte.hu>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>
Message-ID: <20090622081045.E5s8xRMhxQi12jGDADjhAGfu6VQH8B_eBK6CIZAXZ_Q@z>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Just a heads up that I committed the patches that I sent out two 
> months ago to make the fault handling routines use the 
> finer-grained fault flags (FAULT_FLAG_xyzzy) rather than passing 
> in a boolean for "write".

All is fine on x86.

	Ingo
