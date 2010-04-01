From: David Howells <dhowells@redhat.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Thu, 01 Apr 2010 11:50:29 +0100
Message-ID: <31146.1270119029@redhat.com>
References: <20100401094111.GB29433@shareable.org> <20100331210555.GA17715@flint.arm.linux.org.uk> <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <19680.1270076318@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23389 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab0DAKv7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Apr 2010 06:51:59 -0400
In-Reply-To: <20100401094111.GB29433@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, hpa@zytor.com, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:

> Any reason not to use the same technique for all the archs

It depends what atomic instructions you have available.

David
