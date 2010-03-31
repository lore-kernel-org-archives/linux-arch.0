From: David Howells <dhowells@redhat.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 23:58:38 +0100
Message-ID: <19680.1270076318@redhat.com>
References: <20100331210555.GA17715@flint.arm.linux.org.uk> <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758364Ab0CaXA0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 19:00:26 -0400
In-Reply-To: <20100331210555.GA17715@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: dhowells@redhat.com, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, hpa@zytor.com, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:

> We use the standard generic kernel implementation.  Is x86 different? ;)

The optimised fast paths used on x86 rwsems don't disable interrupts.

David
