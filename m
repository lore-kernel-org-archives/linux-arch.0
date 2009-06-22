Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46787 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497AbZFVO6F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2009 10:58:05 -0400
Subject: Re: handle_mm_fault() calling convention cleanup..
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 09:58:01 -0500
Message-ID: <1245682681.6901.2.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090622145801.tWWYVtxd340yQ4XcWAgRVJqiUaFv5Hy3NNEE2yRehTQ@z>

On Sun, 2009-06-21 at 13:42 -0700, Linus Torvalds wrote:
> I hope it works on all architectures. But I thought I'd 
> better give people a shout-out regardless.

Works on parisc.

James


