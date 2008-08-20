From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Wed, 20 Aug 2008 11:50:09 -0500
Message-ID: <48AC4B41.8080908@linux-foundation.org>
References: <20080818133224.GA5258@wotan.suse.de> <48AADBDC.2000608@linux-foundation.org> <20080820090234.GA7018@wotan.suse.de> <48AC244F.1030104@linux-foundation.org> <20080820162235.GA26894@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33968 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752056AbYHTQu4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Aug 2008 12:50:56 -0400
In-Reply-To: <20080820162235.GA26894@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

Nick Piggin wrote:

> Indeed that would be a good use for it if this general fallback mechanism
> were to be merged.

Want me to rebase my virtualizable compound patchset on top of your vmap changes?
