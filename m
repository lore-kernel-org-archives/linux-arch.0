From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] memory_hotplug: disable the functionality for 32b
 (was: Re: [Bug 206401] kernel panic on Hyper-V after 5 minutes due to)
 memory hot-add
Date: Wed, 19 Feb 2020 13:46:45 -0800
Message-ID: <20200219134645.7430db57e0e59f69e7386f46@linux-foundation.org>
References: <20200218084700.GD21113@dhcp22.suse.cz>
        <200218181900.M0115079@vega.pgw.jp>
        <20200218100532.GA4151@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgBSVqr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 16:46:47 -0500
In-Reply-To: <20200218100532.GA4151@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: kkabe@vega.pgw.jp, bhe@redhat.com, david@redhat.com, osalvador@suse.de, bugzilla-daemon@bugzilla.kernel.org, richardw.yang@linux.intel.com, n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 18 Feb 2020 11:05:32 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> Subject: [PATCH] memory_hotplug: disable the functionality for 32b
> 
> Memory hotlug is broken for 32b systems at least since c6f03e2903c9
> ("mm, memory_hotplug: remove zone restrictions") which has considerably
> reworked how can be memory associated with movable/kernel zones. The
> same is not really trivial to achieve in 32b where only lowmem is the
> kernel zone. While we can tweak this immediate problem around there are
> likely other land mines hidden at other places.
> 
> It is also quite dubious that there is a real usecase for the memory
> hotplug on 32b in the first place. Low memory is just too small to be
> hotplugable (for hot add) and generally unusable for hotremove. Adding
> more memory to highmem is also dubious because it would increase the
> low mem or vmalloc space pressure for memmaps.
> 
> Restrict the functionality to 64b systems. This will help future
> development to focus on usecases that have real life application.  We
> can remove this restriction in future in presence of a real life usecase
> of course but until then make it explicit that hotplug on 32b is broken
> and requires a non trivial amount of work to fix.

(cc linux-arch)

(and linux-arm-kernel, as ARM is a major 32-bit user)

Does anyone see a problem with disabling memory hotplug on 32-bit builds?
