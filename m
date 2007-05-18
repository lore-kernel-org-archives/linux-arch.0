Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33807 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754962AbXERHVh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 03:21:37 -0400
Date: Fri, 18 May 2007 00:19:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rfc] increase struct page size?!
Message-Id: <20070518001905.54cafeeb.akpm@linux-foundation.org>
In-Reply-To: <20070518040854.GA15654@wotan.suse.de>
References: <20070518040854.GA15654@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 18 May 2007 06:08:54 +0200 Nick Piggin <npiggin@suse.de> wrote:

> Many batch operations on struct page are completely random,

But they shouldn't be: we should aim to place physically contiguous pages
into logically contiguous pagecache slots, for all the reasons we
discussed.

If/when that happens, there will be a *lot* of locality of reference
against the pageframes in a lot of important codepaths.

