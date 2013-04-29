Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58268 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759015Ab3D2UWk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2013 16:22:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id 4so3833742pdd.17
        for <linux-arch@vger.kernel.org>; Mon, 29 Apr 2013 13:22:40 -0700 (PDT)
Date: Mon, 29 Apr 2013 13:22:38 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 0/2] mm: Promote huge_pmd_share from x86 to mm.
In-Reply-To: <1367247356-11246-1-git-send-email-steve.capper@linaro.org>
Message-ID: <alpine.DEB.2.02.1304291321070.29766@chino.kir.corp.google.com>
References: <1367247356-11246-1-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20130429202238.BmDODX903Phgj4r2pNLS4okvC2qijEefjbTJdrDu-l4@z>

On Mon, 29 Apr 2013, Steve Capper wrote:

> Under x86, multiple puds can be made to reference the same bank of
> huge pmds provided that they represent a full PUD_SIZE of shared
> huge memory that is aligned to a PUD_SIZE boundary.
> 
> The code to share pmds does not require any architecture specific
> knowledge other than the fact that pmds can be indexed, thus can
> be beneficial to some other architectures.
> 
> This RFC promotes the huge_pmd_share code (and dependencies) from
> x86 to mm to make it accessible to other architectures.
> 
> I am working on ARM64 support for huge pages and rather than
> duplicate the x86 huge_pmd_share code, I thought it would be better
> to promote it to mm.
> 

No objections to this, but I think you should do it as the first patch in 
a series that adds the arm support.  There's no need for this to be moved 
until that support is tested, proposed, reviewed, and merged.
