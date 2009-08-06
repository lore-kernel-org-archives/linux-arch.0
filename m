From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] [11/19] HWPOISON: Refactor truncate to allow direct
	truncating of page v2
Date: Thu, 6 Aug 2009 14:04:17 +0200
Message-ID: <20090806120417.GC22124@basil.fritz.box>
References: <200908051136.682859934@firstfloor.org> <20090805093638.D3754B15D8@basil.firstfloor.org> <20090805102008.GB17190@wotan.suse.de> <20090805134607.GH11385@basil.fritz.box> <20090805140145.GB28563@wotan.suse.de> <20090805141001.GJ11385@basil.fritz.box> <20090805141642.GB23992@wotan.suse.de> <20090806134830.4f3931d2@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:57803 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZHFMES (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2009 08:04:18 -0400
Content-Disposition: inline
In-Reply-To: <20090806134830.4f3931d2@skybase>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Andi Kleen <andi@firstfloor.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, fengguang.wu@intel.com, hidehiro.kawai.ez@hitachi.com, linux-arch@vger.kernel.org

> This is not relevant for s390, as current machines do transparent memory
> sparing if a memory module goes bad. Really old machines reported bad
> memory to the OS by means of a machine check (storage error uncorrected
> and storage error corrected). I have never seen this happen, the level
> below the OS deals with these errors for us.

Ok fine. It's for the poorer cousins then who can't afford memory mirroring.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
