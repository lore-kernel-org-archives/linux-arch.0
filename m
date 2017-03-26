From: Borislav Petkov <bp@alien8.de>
Subject: Re: Splat during resume
Date: Sun, 26 Mar 2017 10:41:50 +0200
Message-ID: <20170326084149.pisqkhngxjd65u6g@pd.tnic>
References: <20170325185855.4itsyevunczus7sc@pd.tnic>
 <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
 <1490516743.17559.7.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40324 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdCZImS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Mar 2017 04:42:18 -0400
Content-Disposition: inline
In-Reply-To: <1490516743.17559.7.camel@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86-ml <x86@kernel.org>

On Sun, Mar 26, 2017 at 10:25:43AM +0200, Mike Galbraith wrote:
> To be filed under "_maybe_ interesting", my tip-rt tree hits the below
> on boot (survives), ONLY on vaporite (kvm), silicon boots clean, works
> fine, hibernate/suspend gripe free.

Strange - I did boot fine but resume shit in its pants.

> The revert fixed up vaporite.

vaporite, haha, good one. I like that, let's do
s/vaporitization/virtualization/g from now on :-)

Btw, try the 6 patches here: https://marc.info/?l=linux-mm&m=148977696117208&w=2
ontop of tip. Should fix your vaporite too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
