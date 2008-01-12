Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44249 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbYALCiE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Jan 2008 21:38:04 -0500
Date: Sat, 12 Jan 2008 03:37:59 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH/RFC] synchronize_rcu(): high latency on idle system
Message-ID: <20080112023759.GG21068@bingen.suse.de>
References: <20080112012626.GI28570@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080112012626.GI28570@kvack.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> And yes, the 
> network stack shouldn't call synchronize_rcu() quite so much, but fixing that 
> is a little more involved.

... but the correct solution.

-Andi
