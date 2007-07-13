Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42146 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXGMOw0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 10:52:26 -0400
Date: Fri, 13 Jul 2007 23:51:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 3/7] Generic Virtual Memmap support for SPARSEMEM
Message-Id: <20070713235121.538ddcaf.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <E1I9LJY-00006o-GK@hellhawk.shadowen.org>
References: <exportbomb.1184333503@pinky>
	<E1I9LJY-00006o-GK@hellhawk.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, npiggin@suse.de, clameter@sgi.com, mel@csn.ul.ie
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007 14:36:08 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> SPARSEMEM is a pretty nice framework that unifies quite a bit of
> code over all the arches. It would be great if it could be the
> default so that we can get rid of various forms of DISCONTIG and
> other variations on memory maps. So far what has hindered this are
> the additional lookups that SPARSEMEM introduces for virt_to_page
> and page_address. This goes so far that the code to do this has to
> be kept in a separate function and cannot be used inline.
> 
Maybe it will be our(my or Goto-san's) work to implement MEMORY_HOTADD support
for this. Could you add !MEMORY_HOTPLUG in Kconfig ? Then, we'll write
patch later.
Or..If you'll add memory hotplug support by yourself, It's great, 

-Kame
