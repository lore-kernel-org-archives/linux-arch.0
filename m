Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759149AbXKTREx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2007 12:04:53 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071120165812.GH12494@parisc-linux.org>
References: <20071120165812.GH12494@parisc-linux.org> <20071120160220.GA22196@wotan.suse.de> <4680.1195577182@redhat.com>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Date: Tue, 20 Nov 2007 17:04:46 +0000
Message-ID: <4873.1195578286@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: dhowells@redhat.com, Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox <matthew@wil.cx> wrote:

> > Should there be a spin_lock_io() for example?
> 
> Then we need ...

Yeah.

David
