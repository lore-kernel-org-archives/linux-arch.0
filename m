Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:37571 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160AbXFFJyD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jun 2007 05:54:03 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] mm: variable length argument support
Date: Wed, 6 Jun 2007 11:53:47 +0200
References: <20070605150523.786600000@chello.nl> <20070606094401.GA10393@linux-sh.org> <1181123220.7348.193.camel@twins>
In-Reply-To: <1181123220.7348.193.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706061153.48071.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-arch.vger.kernel.org>


> could do I guess, but doesn't this modern gcc thing auto inline statics
> that are so small?

Yes it does.

-Andi
