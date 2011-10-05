From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, arch: Complete pagefault_disable abstraction
Date: Wed, 5 Oct 2011 14:39:07 -0700
Message-ID: <20111005143907.09283b14.akpm@linux-foundation.org>
References: <1317820169.6766.20.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41812 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446Ab1JEVjK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2011 17:39:10 -0400
In-Reply-To: <1317820169.6766.20.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 05 Oct 2011 15:09:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Currently we already have pagefault_{disable,enable}() but they're
> nothing more than a glorified preempt_{disable,enable}().

That's not very accurate or useful.  Unlike preempt_disable(),
pagefault_disable() will raise the preempt count when CONFIG_PREEMPT=n.
